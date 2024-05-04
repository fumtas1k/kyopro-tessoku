# 素集合データ構造(Union-Find木)

class DSU
  attr_accessor :parent_or_size

  def initialize(n)
    # 負の整数の場合、絶対値が連結成分数を表す
    @parent_or_size = Array.new(n, -1)
  end

  def root(u)
    return u if parent_or_size[u] < 0
    parent_or_size[u] = root(parent_or_size[u])
  end

  def unite(u, v)
    ru, rv = root(u), root(v)
    return if ru == rv
    # サイズが大きい方が小さい方を吸収する方が速度が速い
    ru, rv = rv, ru if size(ru) < size(rv)
    parent_or_size[ru] += parent_or_size[rv]
    parent_or_size[rv] = ru
  end

  def same?(u, v) = root(u) == root(v)

  def size(u) = - parent_or_size[root(u)]

  def groups = parent_or_size.size.times.group_by { root(_1) }

  def roots = parent_or_size.size.times.filter { parent_or_size[_1] < 0 }
end
