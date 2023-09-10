# B16
# 動的計画法
# 実行時間: 1s以内

N = gets.to_i
H = gets.split.map(&:to_i)

dp = [Float::INFINITY] * (N)
dp[0] = 0

1.upto(N - 1) do |i|
  dp[i] = dp[i - 1] + (H[i] - H[i - 1]).abs
  dp[i] = [dp[i], dp[i - 2] + (H[i] - H[i - 2]).abs].min if i >= 2
end

puts dp[-1]
