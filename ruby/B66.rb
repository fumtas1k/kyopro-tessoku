# B66
# UNION FIND
# 2s以内

class UnionFind
  private attr_accessor :parents
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
    parents[ru] = rv
  end

  def same?(u, v) = root(u) == root(v)
end

N, M = gets.split.map(&:to_i)
AB = Array.new(M) { gets.split.map(&:to_i) }
Q = gets.to_i
QUERY = []
canceled = {}
Q.times do
  QUERY << gets.split.map(&:to_i)
  case QUERY[-1]
  in [1, x]
    canceled[x - 1] = true
  else
  end
end

uf = UnionFind.new(N + 1)
# 運休ではない路線を処理する
AB.each_with_index do |(a, b), i|
  uf.unite(a, b) unless canceled[i]
end

ans = []
# クエリの逆から処理し運休の路線を結合していく
QUERY.reverse.each do |query|
  case query
  in [1, x]
    uf.unite(*AB[x - 1])
  in [2, u, v]
    ans << (uf.same?(u, v) ? "Yes" : "No")
  end
end

puts ans.reverse
