# B23
# 動的計画法
# bitDP
# 実行時間: 1s以内

N = gets.to_i
XY = Array.new(N) { gets.split.map(&:to_i) }
dist = Array.new(N) { [0] * N }

N.times do |i|
  (i + 1 .. N - 1).each do |j|
    dist[i][j] = dist[j][i] = Math.sqrt((XY[i][0] - XY[j][0]) ** 2 + (XY[i][1] - XY[j][1]) ** 2)
  end
end

dp = Array.new(N) { Array.new(1 << N, Float::INFINITY) }
dp[0][0] = 0

(1 << N).times do |bits|
  N.times do |i|
    next if dp[i][bits] == Float::INFINITY
    N.times do |j|
      next unless bits[j].zero?
      dp[j][bits + (1 << j)] = [dp[j][bits + (1 << j)], dp[i][bits] + dist[i][j]].min
    end
  end
end

puts dp[0][(1 << N) - 1]
