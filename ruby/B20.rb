# B20
# 動的計画法
# 最長共通部分列
# 実行時間: 1s以内

S = gets.chomp.chars
T = gets.chomp.chars

dp = Array.new(S.size + 1) { [Float::INFINITY] * (T.size + 1) }
dp[0][0] = 0

(S.size + 1).times do |i|
  (T.size + 1).times do |j|
    # 削除操作
    dp[i][j] = dp[i - 1][j] + 1 if i >= 1
    # 挿入操作
    dp[i][j] = [dp[i][j], dp[i][j - 1] + 1].min if j >= 1
    if i >= 1 && j >= 1
      # 変更操作 or 変更しない
      dp[i][j] = [dp[i][j], dp[i - 1][j - 1] + (S[i - 1] == T[j - 1] ? 0 : 1)].min
    end
  end
end

puts dp[-1][-1]
