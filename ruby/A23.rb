# A23
# 動的計画法
# bitDP
# 実行時間: 1s以内

N, M = gets.split.map(&:to_i)
A = Array.new(M) { gets.split.join.to_i(2) }

dp = Array.new(1 << N, Float::INFINITY)
dp[0] = 0

(1 << N).times do |bits|
  M.times do |i|
    dp[bits | A[i]] = [dp[bits | A[i]], dp[bits] + 1].min
  end
end

puts dp[(1 << N) - 1] == Float::INFINITY ? -1 : dp[(1 << N) - 1]
