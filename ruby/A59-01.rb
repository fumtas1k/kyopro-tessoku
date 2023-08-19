# A59
# セグメント木(RSQ)
# 実行時間: 3s以内

class SegmentTree
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

  def update(pos, x)
    idx = pos + leaf_size - 1
    tree[idx] = x
    while idx > 1
      idx /= 2
      tree[idx] = operator.call(tree[idx * 2], tree[idx * 2 + 1])
    end
  end

  def query(l, r, a = 1, b = leaf_size + 1, idx = 1)
    return id_elm if r <= a || b <= l
    return tree[idx] if l <= a && b <= r
    mid = (a + b) / 2
    left = query(l, r, a, mid, idx * 2)
    right = query(l, r, mid, b, idx * 2 + 1)
    operator.call(left, right)
  end
end

N, Q = gets.split.map(&:to_i)
QUERY = Array.new(Q) { gets.split.map(&:to_i) }

seg_tree = SegmentTree.new([0] * N, 0) {|i, j| [i, j].sum }

QUERY.each do |query|
  case query[0]
  when 1
    seg_tree.update(*query[1, 2])
  when 2
    puts seg_tree.query(*query[1, 2])
  end
end
