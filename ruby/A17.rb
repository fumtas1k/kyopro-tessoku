# A17
# 動的計画法
# DP復元
# 実行時間: 1s以内

N = gets.to_i
A = [Float::INFINITY] * 2 + gets.split.map(&:to_i)
B = [Float::INFINITY] * 3 + gets.split.map(&:to_i)
dp = [Float::INFINITY] * (N + 1)
dp[1 .. 2] = [0, A[2]]

3.upto(N) do |i|
  dp[i] = [dp[i - 1] + A[i], dp[i - 2] + B[i]].min
end

ans_rev = [N]
i = N
while i > 1
  if dp[i] == dp[i - 1] + A[i]
    ans_rev << i - 1
    i -= 1
  else
    ans_rev << i - 2
    i -=2
  end
end

puts ans_rev.size
puts ans_rev.reverse.join(" ")
