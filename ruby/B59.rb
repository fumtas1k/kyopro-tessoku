# B59
# セグメント木(RSQ)
# 実行時間: 2.5s以内

class SegmentTree
  private attr_accessor :leaf_size, :tree, :id_elm, :ope

  def initialize(arr, id_elm, &block)
    n = arr.size
    @leaf_size = (1 << (n - 1)).bit_length
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
    return id_elm if l < 0 || r > N || l >= r
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

  def [](pos)
    tree[leaf_size + pos]
  end
end

N = gets.to_i
A = gets.split.map(&:to_i).map(&:pred)
seg_tree = SegmentTree.new([0] * N, 0) {|x, y| x + y }

ans = []
(N - 1).downto(0) do |i|
  ans[i] = seg_tree.query(0, A[i])
  seg_tree.update(A[i], seg_tree[A[i]] + 1)
end

puts ans.sum
