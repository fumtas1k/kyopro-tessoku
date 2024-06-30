# セグメント木

class SegmentTreeW
  # leaf_size: 葉の数
  # ope: 演算メソッド(合計, 最大値, 最小値などの計算)
  # id_elm: 単位元(演算メソッドで結果がもう一方の値と同じとなる要素。足し算なら0、掛け算なら1。)
  # tree: 全体の配列(インデックス0は使用しない)
  attr_accessor :leaf_size, :ope, :id_elm, :tree, :size

  def initialize(arr, id_elm, &method)
    @size = arr.size
    @ope = method
    @id_elm = id_elm
    @leaf_size = 1 << (@size - 1).bit_length
    @tree = Array.new(2 * @leaf_size, @id_elm)
    arr.each_with_index { @tree[@leaf_size + _2] = _1 }
    (@leaf_size - 1).downto(1) { update(_1) }
  end

  def get(pos)
    tree[leaf_size + pos]
  end
  alias [] get

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
  alias []= set

  # 値の取得
  # [0, size)
  def all_prod
    tree[1]
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

  # l以上のfを満たす最大のindex+1
  # return f.call(prod(l, r))を満たす最大のr
  def max_right(l, &f)
    return size if l == size

    left = leaf_size + l
    sm = id_elm
    loop do
      left >>= 1 while left.even?
      unless f.call(ope.call(sm, tree[left]))
        while left < leaf_size
          left <<= 1
          if f.call(ope.call(sm, tree[left]))
            sm = ope.call(sm, tree[left])
            left += 1
          end
        end
        return left - leaf_size
      end

      sm = ope.call(sm, tree[left])
      left += 1
      break if left & -left == left
    end
    size
  end

  # r未満でfを満たす最小のindex
  # f.call(prod(l, r))を満たす最小のl
  def min_left(r, &f)
    return 0 if r.zero?
    r = size if r == -1

    right = r + leaf_size
    sm = id_elm
    loop do
      right -= 1
      right >>= 1 while right > 1 && right.odd?
      unless f.call(ope.call(sm, tree[right]))
        while right < leaf_size
          right += right + 1
          if f.call(ope.call(sm, tree[right]))
            sm = ope.call(sm, tree[right])
            right -= 1
          end
        end
        return right + 1 - leaf_size
      end
      sm = ope.call(sm, tree[right])
      break if right & -right == right
    end
    0
  end

  private
  def update(idx)
    tree[idx] = ope.call(tree[2 * idx, 2 * idx + 1])
  end
end
