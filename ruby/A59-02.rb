# A59
# セグメント木(RSQ)
# 実行時間: 3s以内

class SegmentTree
  # leaf_size: 葉の数
  # operator: 演算メソッド(合計, 最大値, 最小値などの計算)
  # id_elm: 単位元(演算メソッドで結果がもう一方の値と同じとなる要素。足し算なら0、掛け算なら1。)
  # tree: 全体の配列(インデックス0は使用しない)
  attr_accessor :leaf_size, :tree, :id_elm, :ope

  def initialize(arr, id_elm, &block)
    n = arr.size
    @leaf_size = (1 << (n - 1)).bit_length
    @id_elm = id_elm
    @ope = block
    @tree = Array.new(2 * leaf_size) { @id_elm }
    arr.each.with_index(leaf_size) {|a, i| tree[i] = a }
    (leaf_size - 1).downto(1) { tree[_1] = ope.call(tree[2 * _1], tree[2 * _1 + 1]) }
  end

  # 更新
  # pos arrのindex
  # x 更新する値
  def update(pos, value)
    idx = leaf_size + pos
    tree[idx] = value
    while idx > 1
      idx /= 2
      tree[idx] = ope.call(tree[2 * idx], tree[2 * idx + 1])
    end
  end

  # 値の取得
  # [l, r)　求めたい半開区間
  # return 値
  def query(l, r)
    l_idx = leaf_size + l
    r_idx = leaf_size + r - 1
    l_result = id_elm
    r_result = id_elm
    while l_idx <= r_idx
      if l_idx[0] == 1
        l_result = ope.call(l_result, tree[l_idx])
        l_idx += 1
      end
      if r_idx[0].zero?
        r_result = ope.call(r_result, tree[r_idx])
        r_idx -= 1
      end
      l_idx /= 2
      r_idx /= 2
    end
    ope.call(l_result, r_result)
  end
end

N, Q = gets.split.map(&:to_i)
seg_tree = SegmentTree.new([0] * N, 0) {|x, y| x + y }
ans = []
Q.times do
  case gets.split.map(&:to_i)
  in [1, pos, x]
    seg_tree.update(pos - 1, x)
  in [2, l, r]
    ans << seg_tree.query(l - 1, r - 1)
  end
end

puts ans
