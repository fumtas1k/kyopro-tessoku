# B32
# 動的計画法
# 石取り
# 実行時間(5s)

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
# dp[i: 石の数]　:= 先手が勝ち true, 負け false
dp = Array.new(N + 1, false)

1.upto(N) do |i|
  dp[i] = A.any? { i >= _1 && !dp[i - _1] }
end

puts dp[-1] ? "First" : "Second"
