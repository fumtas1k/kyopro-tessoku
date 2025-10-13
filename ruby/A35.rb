# A35
# 動的計画法
# 後ろから考える
# 実行時間: 1s以内

N = gets.to_i
A = gets.split.map(&:to_i)

dp = A
(N - 2).downto(0) do |i|
  ep = []
  (i + 1).times do |j|
    ep[j] = if i.even?
      [dp[j], dp[j + 1]].max
    else
      [dp[j], dp[j + 1]].min
    end
  end
  dp = ep
end

puts dp[0]
