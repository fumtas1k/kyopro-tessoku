# A68
# Ford-Fulkerson法
# Maximum Flow

start_time = Time.now

Edge = Struct.new(:to, :cap, :rev)

class MaximumFlow

  attr_accessor :size, :used, :graph

  def initialize(size)
    @size = size + 1
    @used = [false] * @size
    @graph = Array.new(@size) { [] }
  end

  # 頂点u -> 頂点v, 上限c の辺追加
  def add_edge(a, b, c)
    graph_a_size = graph[a].size
    graph_b_size = graph[b].size
    graph[a] << Edge.new(b, c, graph_b_size)
    graph[b] << Edge.new(a, 0, graph_a_size)
  end

  def dfs(pos, goal, min_flow)
    return min_flow if pos == goal
    used[pos] = true
    graph[pos].each do |edge|
      next if edge.cap.zero? || used[edge.to]
      flow = dfs(edge.to, goal, [min_flow, edge.cap].min)
      next if flow.zero?
      edge.cap -= flow
      graph[edge.to][edge.rev].cap += flow
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

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N, M = f.gets.split.map(&:to_i)
  ABC = Array.new(M) { f.gets.split.map(&:to_i) }
end

mf = MaximumFlow.new(N)
ABC.each do |abc|
  mf.add_edge(*abc)
end

puts mf.max_flow(1, N)

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
