# C14
# ダイクストラ法

require "ac-library-rb/priority_queue"

N, M = gets.split.map(&:to_i)
G = Array.new(N) { [] }
M.times do
  a, b, c = gets.split.map(&:to_i)
  G[a - 1] << [b - 1, c]
  G[b - 1] << [a - 1, c]
end

def dijkstra(start = 0)
  dists = [Float::INFINITY] * N
  dists[start] = 0
  log = AcLibraryRb::PriorityQueue.new([[start, 0]]) {|a, b| a[1] < b[1] }
  until log.empty?
    u, cu = log.pop
    next if dists[u] < cu
    G[u].each do |v, cv|
      cost = dists[u] + cv
      next if dists[v] <= cost
      dists[v] = cost
      log << [v, cost]
    end
  end
  dists
end

one_to_n = dijkstra(0)
n_to_one = dijkstra(N - 1)

ans = 1.upto(N - 1).count do |i|
  one_to_n[i] + n_to_one[i] == one_to_n[-1]
end

puts ans + 1
