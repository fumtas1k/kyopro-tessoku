# A63
# 幅優先探索
# Breadth First Search(BFS)

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

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
M.times do
  a, b = gets.split.map { _1.to_i.pred }
  G[a] << b
  G[b] << a
end

puts bfs(0)
