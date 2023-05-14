# A67
# 最小全域木
# クラスカル法(貪欲法 + Union-Find木)
# 実行時間: 1s以内

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

N, M = gets.split.map(&:to_i)
ABC = Array.new(M) { gets.split.map(&:to_i) }.sort_by { _1[-1] }

uf = UnionFind.new(N + 1)

ans = ABC.sum do |a, b, c|
  if uf.same?(a, b)
    0
  else
    uf.unite(a, b)
    c
  end
end

puts ans
