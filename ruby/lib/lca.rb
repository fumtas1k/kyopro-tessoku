class LCA
  attr_reader :parents, :depth, :orders, :edges, :bit, :size

  def initialize(n)
    @size = n
    @bit = n.bit_length
    @parents = Array.new(bit) { Array.new(n) }
    @depth = Array.new(n, -1)
    @depth[0] = 0
    @orders = Array.new(n)
    @edges = Array.new(n) { [] }
    @current_order = 0
  end

  def add_edge(u, v)
    edges[u] << v
    edges[v] << u
  end

  def build
    current_order = 0
    dfs = -> (pos = 0, pre = 0) do
      parents[0][pos] = pre
      orders[pos] = current_order
      current_order += 1
      edges[pos].each do |to|
        next if to == pre
        depth[to] = depth[pos] + 1
        dfs.(to, pos)
      end
    end

    dfs.()

    (bit - 1).times do |i|
      size.times do |j|
        parents[i + 1][j] = parents[i][parents[i][j]]
      end
    end
  end

  def get(u, v)
    u, v = v, u if depth[u] < depth[v]
    diff = depth[u] - depth[v]
    bit.times do |i|
      next if diff[i].zero?
      u = parents[i][u]
    end
    return u if u == v

    (bit - 1).downto(0) do |i|
      next if parents[i][u] == parents[i][v]
      u = parents[i][u]
      v = parents[i][v]
    end
    parents[0][u]
  end
end
