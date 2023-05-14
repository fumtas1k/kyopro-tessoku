# A64
# ダイクストラ法

def dijukstra(start, n, graph)
  dist = [Float::INFINITY] * (n + 1)
  dist[start] = 0

  que = [start]
  fixed = [false] * (n + 1)

  until que.empty?
    pos = que.shift
    next if fixed[pos]
    fixed[pos] = true

    G[pos].each do |to, c|
      cost = dist[pos] + c
      next if dist[to] <= cost
      dist[to] = cost
      # 本来はpriority queueを用いるのだが、rubyにはないため2分探索と配列の組み合わせ
      idx = que.bsearch_index { dist[_1] >= cost} || que.size
      que.insert(idx, to)
    end
  end
  dist[1..]
end

N, M = gets.split.map(&:to_i)
G = Array.new(N + 1) { [] }
M.times do
  a, b, c = gets.split.map(&:to_i)
  G[a] << [b, c]
  G[b] << [a, c]
end

puts dijukstra(1, N, G)
