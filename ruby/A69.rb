# A69
# 二部マッチング
# Ford-Fulkerson法

class MaxFlow

  attr_accessor :used, :graph

  Edge = Struct.new(:to, :to_idx, :cap)

  def initialize(size)
    @used = [false] * (size + 1)
    @graph = Array.new(size + 1) { [] }
  end

  # 頂点from -> 頂点to, 上限cap の辺追加
  def add_edge(from, to, cap)
    from_idx = graph[from].size
    to_idx = graph[to].size
    graph[from] << Edge.new(to, to_idx, cap)
    graph[to] << Edge.new(from, from_idx, 0)
  end

  def max_flow(u, v)
    total_flow = 0
    while true
      used.fill(false)
      flow = dfs(u, v, Float::INFINITY)
      break if flow.zero?
      total_flow += flow
    end
    total_flow
  end

  private
  # goalに辿り着く最小流量を求める
  def dfs(pos, goal, min_flow)
    return min_flow if pos == goal
    used[pos] = true
    graph[pos].each do |edge|
      next if edge.cap.zero? || used[edge.to]
      flow = dfs(edge.to, goal, [min_flow, edge.cap].min)
      next if flow.zero?
      edge.cap -= flow
      graph[edge.to][edge.to_idx].cap += flow
      return flow
    end
    0
  end
end

N = gets.to_i
C = Array.new(N) { gets.chomp.chars }

max_flow = MaxFlow.new(2 * N + 2)
1.upto(N) do |i|
  max_flow.add_edge(2 * N + 1, i, 1)
  max_flow.add_edge(N + i, 2 * N + 2, 1)
  1.upto(N) do |j|
    next if C[i - 1][j - 1] == "."
    max_flow.add_edge(i, N + j, 1)
  end
end
puts max_flow.max_flow(2 * N + 1, 2 * N + 2)
