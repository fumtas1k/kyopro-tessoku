# A18
# 動的計画法
# 部分和問題
# 実行時間: 1s以内


N, S = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

dp = Array.new(N + 1) { [false] * (S + 1) }
dp[0][0] = true

N.times do |i|
  (S + 1).times do |j|
    dp[i + 1][j] = dp[i][j]
    dp[i + 1][j] = true if j >= A[i] && dp[i][j - A[i]]
  end
end

puts dp[-1][-1] ? "Yes" : "No"
