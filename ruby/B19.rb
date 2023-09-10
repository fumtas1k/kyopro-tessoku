# B19
# 動的計画法
# ナップザック問題
# 実行時間: 2s以内

N, W = gets.split.map(&:to_i)
WV = Array.new(N) { gets.split.map(&:to_i) }
V_MAX = WV.sum(&:last)

dp = Array.new(N + 1) { [Float::INFINITY] * (V_MAX + 1) }
dp[0][0] = 0

WV.each_with_index do |(dw, dv), i|
  (V_MAX + 1).times do |v|
    dp[i + 1][v] = dp[i][v]
    dp[i + 1][v] = [dp[i + 1][v], dp[i][v - dv] + dw].min if v >= dv
  end
end

puts (0 .. V_MAX).filter { dp[-1][_1] <= W }.max
