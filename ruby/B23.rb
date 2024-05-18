# B23
# 動的計画法
# bitDP
# 実行時間: 1s以内

N = gets.to_i
XY = Array.new(N) { gets.split.map(&:to_i) }
DIST = Array.new(N) { Array.new(N, 0) }
N.times do |i|
  (i + 1).upto(N - 1) do |j|
    DIST[i][j] = DIST[j][i] = XY[i].zip(XY[j]).sum { (_1 - _2) ** 2 }.then { Math.sqrt(_1) }
  end
end

dp = Array.new(1 << N) { Array.new(N, Float::INFINITY) }
dp[0][0] = 0

(1 << N).times do |bit|
  N.times do |i|
    next if dp[bit][i] == Float::INFINITY
    N.times do |j|
      next if bit[j] == 1 || i == j
      dp[bit | (1 << j)][j] = [dp[bit | (1 << j)][j], dp[bit][i] + DIST[i][j]].min
    end
  end
end

puts dp[-1][0]
