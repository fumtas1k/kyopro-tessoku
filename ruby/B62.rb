# B62
# 深さ優先探索
# DFS
# 実行時間: 1s以内

N, M = gets.split.map(&:to_i)
G = Array.new(N + 1) { [] }

M.times do
  a, b = gets.split.map(&:to_i)
  G[a] << b
  G[b] << a
end

@visited = [false] * (N + 1)
@log = []

def dfs(pos)
  @log << pos
  if pos == N
    puts @log.join(" ")
    exit
  end
  @visited[pos] = true
  G[pos].each do |to|
    next if @visited[to]
    dfs(to)
  end
  @log.pop
  @visited[pos] = false
end

dfs(1)
