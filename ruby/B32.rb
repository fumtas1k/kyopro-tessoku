# B32
# 動的計画法
# 石取り
# 実行時間(5s)

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
# dp[i: 石の数]　:= 手番でi個の石が残っている時に勝つ場合true
# 石が0個で手番になるのは負けなのでdp[0] = falseとする
dp = Array.new(N + 1, false)

1.upto(N) do |i|
  dp[i] = A.any? { i >= _1 && !dp[i - _1] }
end

puts dp[-1] ? "First" : "Second"
