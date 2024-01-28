# C09
# 動的計画法

N = gets.to_i
A = gets.split.map(&:to_i)

# dp[i][j] := i日目, j = 1はその日に勉強、j = 0はその日に勉強していない場合の実力
dp = Array.new(N + 1) { [0] * 2 }

N.times do |i|
  dp[i + 1][0] = [dp[i][1], dp[i][0]].max
  dp[i + 1][1] = dp[i][0] + A[i]
end

puts dp[-1].max
