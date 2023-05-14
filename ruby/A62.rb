# A62
# 深さ優先対策
# Depth First Search(DFS)

def dfs(pos)
  @visited[pos] = true
  G[pos].each do |i|
    next if @visited[i]
    dfs(i)
  end
end

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
M.times do
  a, b = gets.split.map { _1.to_i.pred }
  G[a] << b
  G[b] << a
end

@visited = [false] * N
dfs(0)
isConnected = @visited.all? ? "" : "not "

puts "The graph is #{isConnected}connected."
