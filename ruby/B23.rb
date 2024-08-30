# B23
# 動的計画法
# bitDP
# 実行時間: 1s以内

N = gets.to_i
XY = Array.new(N) { gets.split.map(&:to_i) }
dist = Array.new(N) { Array.new(N, 0) }
N.times do |i|
  (i + 1).upto(N - 1) do |j|
    dist[i][j] = dist[j][i] = XY[i].zip(XY[j]).sum { (_1 - _2) ** 2 }.then { Math.sqrt(_1) }
  end
end

# dp[i][bit]: bitの集合に含まれる頂点を全て通って頂点iに到達する最短距離
dp = Array.new(N) { Array.new(1 << N, Float::INFINITY) }
# 循環するため出発地点を0に固定しても一般性は失われない
dp[0][0] = 0

(1 << N).times do |bit|
  N.times do |i|
    next if dp[i][bit] == Float::INFINITY
    N.times do |j|
      next if bit[j] == 1 || i == j
      dp[j][bit | (1 << j)] = [dp[j][bit | (1 << j)], dp[i][bit] + dist[i][j]].min
    end
  end
end

puts dp[0][-1]
