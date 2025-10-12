# A32
# 動的計画法
# 石取り
# 実行時間(1s)

N, A, B = gets.split.map(&:to_i)
# dp[i: 石の数]　:= 手番でi個の石が残っている時に勝つか
# 遷移する先の状態から手番での石の数での勝ち負けを考える
dp = [false] * (N + 1)

1.upto(N) do |i|
  dp[i] = true if i >= A && !dp[i - A]
  dp[i] = true if i >= B && !dp[i - B]
end

puts dp[-1] ? "First" : "Second"
