# セグメント木

class SegmentTreeW
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
    n.times { tree[leaf_size + _1] = arr[_1] }
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
  def prod(l, r)
    return id_elm if l < 0 || l > r || r > leaf_size
    left = leaf_size + l
    right = leaf_size + r
    res = id_elm
    while left < right
      if left[0] == 1
        res = ope.call(res, tree[left])
        left += 1
      end
      if right[0] == 1
        right -= 1
        res = ope.call(res, tree[right])
      end
      left >>= 1
      right >>= 1
    end
    res
  end

  private
  def update(idx)
    tree[idx] = ope.call(tree[2 * idx, 2 * idx + 1])
  end
end
