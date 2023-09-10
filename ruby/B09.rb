# B09
# 二次元いもす法
# 5s以内

MAX = 1_500
N = gets.to_i
ABCD = Array.new(N) { gets.split.map(&:to_i) }
dp = Array.new(MAX + 1) { [0] * (MAX + 1) }

ABCD.each do |a, b, c, d|
  dp[a][b] += 1
  dp[a][d] -= 1
  dp[c][b] -= 1
  dp[c][d] += 1
end

(MAX + 1).times do |i|
  MAX.times do |j|
    dp[i][j + 1] += dp[i][j]
  end
end
MAX.times do |i|
  (MAX + 1).times do |j|
    dp[i + 1][j] += dp[i][j]
  end
end

puts dp.flatten.count { _1 > 0 }
