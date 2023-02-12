class UnionFind
  attr_accessor :parents

  def initialize(size)
    @parents = Array.new(size, &:itself)
  end

  def root(u)
    return u if u == parents[u]
    parents[u] = root(parents[u])
  end

  def unite(u, v)
    ru, rv = root(u), root(v)
    return if ru == rv
    parents[rv] = ru
  end

  def same?(u, v)
    root(u) == root(v)
  end
end
