# B64
# ダイクストラ法
# 二分探索法
# 3s以内

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
M.times do
  a, b, c = gets.split.map(&:to_i)
  G[a - 1] << [b - 1, c]
  G[b - 1] << [a - 1, c]
end

def dijkstra(start = 0, last = N - 1)
  # dist[pos] = [from, distance]
  dist = Array.new(N) { [_1, Float::INFINITY] }
  dist[start] = [-1, 0]

  # [from, distance]
  log = [[start, 0]]
  until log.empty?
    pos, c = log.shift
    next if dist[pos][1] < c

    G[pos].each do |to, d|
      cost = dist[pos][1] + d
      next if dist[to][1] <= cost
      dist[to] = [pos, cost]
      idx = log.bsearch_index { dist[_1[0]][1] > cost } || log.size
      log.insert(idx, [to, cost])
    end
  end

  from = last
  result = []
  while from != -1
    result << from + 1
    from, _ = dist[from]
  end
  result.reverse
end

puts dijkstra.join(" ")
