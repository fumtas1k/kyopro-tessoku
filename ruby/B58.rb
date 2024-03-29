# B58
# セグメント木(RMQ)
# 実行時間: 2.5s以内

class SegmentTree
  attr_accessor :leaf_size, :size, :tree, :id_elm, :ope

  def initialize(arr, id_elm, &block)
    @size = arr.size
    @leaf_size = 1 << (size - 1).bit_length
    @id_elm = id_elm
    @ope = block
    @tree = Array.new(2 * leaf_size) { @id_elm }
    arr.each.with_index(leaf_size) {|a, i| tree[i] = a }
    (leaf_size - 1).downto(1) { tree[_1] = ope.call(tree[2 * _1], tree[2 * _1 + 1]) }
  end

  def update(pos, value)
    idx = leaf_size + pos
    tree[idx] = value
    while idx > 1
      idx /= 2
      tree[idx] = ope.call(tree[2 * idx], tree[2 * idx + 1])
    end
  end

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

  def last
    tree[leaf_size + size - 1]
  end
end

N, L, R = gets.split.map(&:to_i)
X = gets.split.map(&:to_i)
arr = [Float::INFINITY] * N
arr[0] = 0
seg_tree = SegmentTree.new(arr, Float::INFINITY) {|x, y| [x, y].min }

X[1..].each.with_index(1) do |x, i|
  l = X.bsearch_index { _1 >= [x - R, 0].max }
  r = X.bsearch_index { _1 > [x - L, 0].max } || N
  min = seg_tree.query(l, r)
  seg_tree.update(i, min + 1)
end

puts seg_tree.last
