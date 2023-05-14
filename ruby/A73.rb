# A73
# ダイクストラ法
# わずかなボーナス
# 1s以内

# 小数点計算しないようにするため道路の長さに下駄を履かせる。N <= 8000より値を設定
UP = 10 ** 4

N, M = gets.split.map(&:to_i)
G = Array.new(N + 1) { [] }
M.times do
  a, b, c, d = gets.split.map(&:to_i)
  G[a] << [b, c * UP - d]
  G[b] << [a, c * UP - d]
end

def dijkstra(start)
  dist = [Float::INFINITY] * (N + 1)
  dist[start] = 0
  next_pos = [start]
  until next_pos.empty?
    from = next_pos.shift
    G[from].each do |to, c|
      next if dist[to] <= dist[from] + c
      dist[to] = dist[from] + c
      idx = next_pos.bsearch_index { dist[_1] >= dist[to] } || next_pos.size
      next_pos.insert(idx, to)
    end
  end
  dist[1..]
end

dist_up = dijkstra(1)[-1]
dist = (dist_up / UP.to_f).ceil
