# 58
# セグメント木(RMQ)
# 実行時間: 3s以内

start_time = Time.now

class SegmentTree
  attr_accessor :leaf_size, :operator, :id_elm, :tree

  def initialize(arr, id_elm, &method)
    n = arr.size
    @operator = method
    @id_elm = id_elm
    @leaf_size = 1 << (n - 1).bit_length
    @tree = [id_elm] * leaf_size
    @tree.concat(arr)
    (leaf_size - 1).downto(1) do |i|
      tree[i] = operator.call(tree[i * 2], tree[i * 2 + 1])
    end
  end

  def update(pos, x)
    u = pos + leaf_size - 1
    tree[u] = x
    while u > 1
      u /= 2
      tree[u] = operator.call(tree[u * 2], tree[u * 2 + 1])
    end
  end

  def query(l, r, a, b, u)
    return id_elm if r <= a || b <= l
    return tree[u] if l <= a && b <= r
    mid = (a + b) / 2
    left = query(l, r, a, mid, u * 2)
    right = query(l, r, mid, b, u * 2 + 1)
    operator.call(left, right)
  end
end

File.open("question/A58.txt", "r") do |f|
  N, Q = f.gets.split.map(&:to_i)
  QUERY = Array.new(Q) { f.gets.split.map(&:to_i) }
end

seg_tree = SegmentTree.new([0] * N, -1) {|i, j| [i, j].max }

QUERY.each do |query|
  case query[0]
  when 1
    seg_tree.update(*query[1, 2])
  when 2
    puts seg_tree.query(*query[1, 2], 1, seg_tree.leaf_size + 1, 1)
  end
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
