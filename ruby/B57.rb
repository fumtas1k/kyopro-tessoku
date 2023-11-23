# B57
# ダブリング
# 実行時間: 4s以内

MAX = 30
N, K = gets.split.map(&:to_i)
A = (N + 1).times.map {|i| i - i.to_s.chars.sum { _1.to_i } }

dp = Array.new(MAX) { [] }
dp[0] = A.clone
(MAX - 1).times do |i|
  (N + 1).times do |j|
    dp[i + 1][j] = dp[i][dp[i][j]]
  end
end

ans = Array.new(N + 1, &:itself)
MAX.times do |i|
  next if K[i].zero?
  (N + 1).times { ans[_1] = dp[i][ans[_1]] }
end

puts ans[1 ..]
