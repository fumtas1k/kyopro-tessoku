# A64
# ダイクストラ法
# 二分探索法
# 3s以内

def dijukstra(start, n, graph)
  dist = [Float::INFINITY] * n
  dist[start] = 0
  log = [[start, 0]]

  until log.empty?
    pos, d = log.shift
    next if dist[pos] < d

    G[pos].each do |to, c|
      cost = dist[pos] + c
      next if dist[to] <= cost
      dist[to] = cost
      # 本来はpriority logueを用いるのだが、rubyにはないため2分探索と配列の組み合わせ
      idx = log.bsearch_index { dist[_1[0]] > cost } || log.size
      log.insert(idx, [to, cost])
    end
  end
  dist
end

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
M.times do
  a, b, c = gets.split.map(&:to_i)
  G[a - 1] << [b - 1, c]
  G[b - 1] << [a - 1, c]
end

puts dijukstra(0, N, G).map { _1 == Float::INFINITY ? -1 : _1 }
