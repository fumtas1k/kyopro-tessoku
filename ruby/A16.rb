# A16
# 動的計画法
# 実行時間: 1s以内

N = gets.to_i
A = [Float::INFINITY] * 2 + gets.split.map(&:to_i)
B = [Float::INFINITY] * 3 + gets.split.map(&:to_i)
dp = [Float::INFINITY] * (N + 1)
dp[1 .. 2] = [0, A[2]]

3.upto(N) do |i|
  dp[i] = [dp[i - 1] + A[i], dp[i - 2] + B[i]].min
end

puts dp[-1]
