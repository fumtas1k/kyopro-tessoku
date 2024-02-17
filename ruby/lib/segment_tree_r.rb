# セグメント木

class SegmentTreeR
  # leaf_size: 葉の数
  # ope: 演算メソッド(合計, 最大値, 最小値などの計算)
  # id_elm: 単位元(演算メソッドで結果がもう一方の値と同じとなる要素。足し算なら0、掛け算なら1。)
  # tree: 全体の配列(インデックス0は使用しない)
  attr_accessor :leaf_size, :ope, :id_elm, :tree

  def initialize(arr, id_elm, &method)
    n = arr.size
    @ope = method
    @id_elm = id_elm
    @leaf_size = 1 << (n - 1).bit_length
    @tree = [id_elm] * 2 * leaf_size
    arr.each_with_index {|a, i| tree[leaf_size + i] = a }
    (leaf_size - 1).downto(1) { update(_1) }
  end

  # 更新
  # pos arrのindex
  # value 更新する値
  def set(pos, value)
    idx = leaf_size + pos
    tree[idx] = value
    while idx > 1
      update(idx >>= 1)
    end
  end

  # 値の取得
  # [l, r)　求めたい半開区間
  # [a, b) 現在の半開区間
  # u 現在のtreeのインデックス
  def prod(l, r, a = 0, b = leaf_size, idx = 1)
    return id_elm if r <= a || b <= l
    return tree[idx] if l <= a && b <= r
    mid = (a + b) / 2
    res_l = prod(l, r, a, mid, idx * 2)
    res_r = prod(l, r, mid, b, idx * 2 + 1)
    ope.call(res_l, res_r)
  end

  private
  def update(idx)
    tree[idx] = ope.call(tree[2 * idx], tree[2 * idx + 1])
  end
end
