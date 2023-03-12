# A63
# 幅優先探索
# Breadth First Search(BFS)

start_time = Time.now

def bfs(start)
  dist = [-1] * N
  dist[start] = 0
  deque = [start]
  until deque.empty?
    from = deque.shift
    G[from].each do |to|
      next unless dist[to] == -1
      dist[to] = dist[from] + 1
      deque << to
    end
  end
  dist
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

puts bfs(0)

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
