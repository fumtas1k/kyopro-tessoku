# C19
# セグメント木

class SegTree
  attr_accessor :tree, :leaf_size, :id_elm, :ope

  def initialize(arr, id_elm, &block)
    n = arr.size
    @leaf_size = 1 << (n - 1).bit_length
    @id_elm = id_elm
    @tree = Array.new(2 * @leaf_size, @id_elm)
    @ope = block
    arr.each_with_index {|a, i| @tree[@leaf_size + i] = a }
    (@leaf_size - 1).downto(1) { update(_1) }
  end

  def update(idx)
    tree[idx] = ope.call(tree[2 * idx], tree[2 * idx + 1])
  end

  def set(pos, value)
    idx = leaf_size + pos
    while idx > 1
      update(idx >>= 1)
    end
  end

  def prod(l, r)
    left = leaf_size + l
    right = leaf_size + r
    ans = id_elm
    while right > left
      if left[0] == 1
        ans = ope.call(ans, tree[left])
        left += 1
      end
      if right[0] == 1
        ans = ope.call(ans, tree[right - 1])
        right -= 1
      end
      left >>= 1
      right >>= 1
    end
    ans
  end
end

N, L, K = gets.split.map(&:to_i)
AC = Array.new(N) { gets.split.map(&:to_i) }

# i + 1 リットル目のガソリンを入れた場所をEiとすると
# K - Ei + (i - 1) >= 0　かつ K - Ei + i <= K
# i <= Ei <= i + K - 1
min_value = [Float::INFINITY] * (L - 1)

AC.each do |a, c|
  min_value[a - 1] = [min_value[a - 1], c].min
end

# [i, i + K)の範囲でのガソリンの最小価格を求めるためにSegmentTreeを使用する
st = SegTree.new(min_value, Float::INFINITY) {|a, b| [a, b].min }

ans = 0
(L - K).times do |i|
  ans += st.prod(i, i + K)
  if ans == Float::INFINITY
    puts -1
    exit
  end
end

puts ans

