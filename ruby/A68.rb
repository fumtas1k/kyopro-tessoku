# A68
# Ford-Fulkerson法
# Maximum Flow
# 実行時間: 1s以内

class MaxFlow
  Edge = Struct.new(:to, :to_idx, :cap)
  private attr_accessor :graph, :used

  def initialize(size)
    @graph = Array.new(size) { [] }
    @used = [false] * size
  end

  # 頂点from -> 頂点to, 上限cap の辺追加
  def add_edge(from, to, cap)
    from_size = graph[from].size
    to_size = graph[to].size
    graph[from] << Edge.new(to, to_size, cap)
    graph[to] << Edge.new(from, from_size, 0)
  end

  # 最大流量を計算する
  def calc_max_flow(start, goal)
    total_flow = 0
    loop do
      used.fill(false)
      flow = dfs(start, goal)
      return total_flow if flow.zero?
      total_flow += flow
    end
  end

  private
  # goalに辿り着ける流量を1つ求める
  def dfs(pos, goal, max_flow = Float::INFINITY)
    return max_flow if pos == goal
    used[pos] = true
    graph[pos].each do |edge|
      next if used[edge.to] || edge.cap.zero?
      flow = dfs(edge.to, goal, [max_flow, edge.cap].min)
      next if flow.zero?
      edge.cap -= flow
      graph[edge.to][edge.to_idx].cap += flow
      return flow
    end
    0
  end
end

N, M = gets.split.map(&:to_i)
mf = MaxFlow.new(N)
M.times do
  abc = gets.split.map(&:to_i).then { [_1[0].pred, _1[1].pred, _1[2]] }
  mf.add_edge(*abc)
end
puts mf.calc_max_flow(0, N - 1)
