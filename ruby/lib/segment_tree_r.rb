# セグメント木

class SegmentTreeR
  # leaf_size: 葉の数
  # operator: 演算メソッド(合計, 最大値, 最小値などの計算)
  # id_elm: 単位元(演算メソッドで結果がもう一方の値と同じとなる要素。足し算なら0、掛け算なら1。)
  # tree: 全体の配列(インデックス0は使用しない)
  attr_accessor :leaf_size, :operator, :id_elm, :tree

  def initialize(arr, id_elm, &method)
    n = arr.size
    @operator = method
    @id_elm = id_elm
    @leaf_size = 1 << (n - 1).bit_length
    @tree = [id_elm] * 2 * leaf_size
    n.times { tree[leaf_size + _1] = arr[_1] }
    (leaf_size - 1).downto(1) do |i|
      tree[i] = operator.call(tree[i * 2], tree[i * 2 + 1])
    end
  end

  # 更新
  # pos arrのindex + 1
  # x 更新する値
  def update(pos, x)
    idx = pos + leaf_size - 1
    tree[idx] = x
    while idx > 1
      idx /= 2
      tree[idx] = operator.call(tree[idx * 2], tree[idx * 2 + 1])
    end
  end

  # 値の取得
  # [l, r)　求めたい半開区間
  # [a, b) 現在の半開区間
  # u 現在のtreeのインデックス
  def query(l, r, a = 1, b = leaf_size + 1, idx = 1)
    return id_elm if r <= a || b <= l
    return tree[idx] if l <= a && b <= r
    mid = (a + b) / 2
    left = query(l, r, a, mid, idx * 2)
    right = query(l, r, mid, b, idx * 2 + 1)
    operator.call(left, right)
  end
end
