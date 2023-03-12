# A62
# 深さ優先対策
# Depth First Search(DFS)

start_time = Time.now

def dfs(pos)
  @visited[pos] = true
  G[pos].each do |i|
    next if @visited[i]
    dfs(i)
  end
end

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N, M = f.gets.split.map(&:to_i)
  G = Array.new(N) { [] }
  M.times do
    a, b = f.gets.split.map { _1.to_i.pred }
    G[a] << b
    G[b] << a
  end
end

@visited = [false] * N
dfs(0)
isConnected = @visited.all? ? "" : "not "

puts "The graph is #{isConnected}connected."

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
