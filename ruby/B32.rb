# B32
# 動的計画法
# 石取り
# 実行時間(5s)

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i).sort
# dp[i: 石の数]　:= 先手が勝ち true, 負け false
dp = [false] * (N + 1)

1.upto(N) do |i|
  A.each do |j|
    break if dp[i] || i < j
    dp[i] = true unless dp[i - j]
  end
end

puts dp[-1] ? "First" : "Second"
