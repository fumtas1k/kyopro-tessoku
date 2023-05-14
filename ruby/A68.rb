# A68
# Ford-Fulkerson法
# Maximum Flow

class MaxFlow

  attr_accessor :size, :used, :graph

  Edge = Struct.new(:to, :to_idx, :cap)

  def initialize(size)
    @size = size + 1
    @used = [false] * @size
    @graph = Array.new(@size) { [] }
  end

  # 頂点from -> 頂点to, 上限cap の辺追加
  def add_edge(from, to, cap)
    graph_from_size = graph[from].size
    graph_to_size = graph[to].size
    graph[from] << Edge.new(to, graph_to_size, cap)
    graph[to] << Edge.new(from, graph_from_size, 0)
  end

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

  def max_flow(u, v)
    total_flow = 0
    while true
      @used = [false] * size
      flow = dfs(u, v, Float::INFINITY)
      break if flow.zero?
      total_flow += flow
    end
    total_flow
  end
end

N, M = gets.split.map(&:to_i)
ABC = Array.new(M) { gets.split.map(&:to_i) }

mf = MaxFlow.new(N)
ABC.each do |abc|
  mf.add_edge(*abc)
end

puts mf.max_flow(1, N)
