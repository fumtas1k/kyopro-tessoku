# A23
# 動的計画法
# bitDP
# 実行時間: 1s以内

N, M = gets.split.map(&:to_i)
A = Array.new(M) { gets.split.join.to_i(2) }
dp = Array.new(M + 1) { [Float::INFINITY] * (1 << N) }
dp[0][0] = 0
1.upto(M) do |i|
  a = A[i - 1]
  ((1 << N) - 1).downto(0) do |j|
    dp[i][j] = dp[i - 1][j]
    dp[i][j | a] = [dp[i][j | a], dp[i - 1][j] + 1].min
  end
end

puts dp[-1][-1] == Float::INFINITY ? -1 : dp[-1][-1]
