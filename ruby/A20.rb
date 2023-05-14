# A20
# 動的計画法
# 最長共通部分列
# 実行時間: 1s以内

S = gets.chomp.chars
T = gets.chomp.chars
dp = Array.new(S.size + 1) { [0] * (T.size + 1) }
1.upto(S.size) do |i|
  1.upto(T.size) do |j|
    dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].max
    dp[i][j] = [dp[i][j], dp[i - 1][j - 1] + 1].max if S[i - 1] == T[j - 1]
  end
end
puts dp[-1][-1]
