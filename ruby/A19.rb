# A19
# 動的計画法
# ナップザック問題
# 実行時間: 1s以内

N, W = gets.split.map(&:to_i)
WV = Array.new(N) { gets.split.map(&:to_i) }
dp = Array.new(N + 1) { [0] * (W + 1) }

WV.each_with_index do |(dw, dv), i|
  (W + 1).times do |w|
    dp[i + 1][w] = dp[i][w]
    dp[i + 1][w] = [dp[i + 1][w], dp[i][w - dw] + dv].max if w >= dw
  end
end

puts dp[-1].max
