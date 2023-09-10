# B17
# 動的計画法
# DP復元
# 実行時間: 1s以内

N = gets.to_i
H = gets.split.map(&:to_i)

dp = [Float::INFINITY] * N
dp[0] = 0
dp[1] = (H[1] - H[0]).abs

2.upto(N - 1) do |i|
  dp[i] = [dp[i - 1] + (H[i] - H[i - 1]).abs, dp[i - 2] + (H[i] - H[i - 2]).abs].min
end

i = N - 1
ans_rev = [i + 1]
while i >= 1
  if dp[i] - (H[i] - H[i - 1]).abs == dp[i - 1]
    ans_rev << [i]
    i -= 1
  else
    ans_rev << [i - 1]
    i -= 2
  end
end

puts ans_rev.size
puts ans_rev.reverse.join(" ")
