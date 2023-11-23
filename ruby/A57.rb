# A57
# ダブリング
# 実行時間: 2s以内

# 10 ^ 9 < 2 ^ 30
MAX = 30

N, Q = gets.split.map(&:to_i)
A = gets.split.map(&:to_i).map(&:pred)
dp = Array.new(MAX) { [] }
dp[0] = A.clone
(MAX - 1).times do |i|
  N.times do |j|
    dp[i + 1][j] = dp[i][dp[i][j]]
  end
end

ans = []
Q.times do
  x, y = gets.split.map(&:to_i)
  x -= 1
  MAX.times do |i|
    next if y[i].zero?
    x = dp[i][x]
  end
  ans << x.next
end

puts ans
