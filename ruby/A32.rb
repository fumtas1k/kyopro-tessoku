# A32
# 動的計画法
# 石取り
# 実行時間(1s)

N, A, B = gets.split.map(&:to_i)
# dp[i: 石の数]　:= 手番でi個の石が残っている時に勝つ場合true
# 石が0個で手番になるのは負けなのでdp[0] = falseとする
dp = [false] * (N + 1)

1.upto(N) do |i|
  dp[i] = true if i >= A && !dp[i - A]
  dp[i] = true if i >= B && !dp[i - B]
end

puts dp[-1] ? "First" : "Second"
