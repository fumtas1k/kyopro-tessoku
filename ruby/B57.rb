# B57
# ダブリング
# 実行時間: 4s以内

MAX = 30
N, K = gets.split.map(&:to_i)
DP = Array.new(MAX) { Array.new(N + 1) }
(N + 1).times.map { _1 - _1.digits.sum }.then { DP.unshift(_1) }

MAX.times do |i|
  (N + 1).times do |j|
    DP[i + 1][j] = DP[i][DP[i][j]]
  end
end

ans = Array.new(N + 1, &:itself)
MAX.times do |i|
  next if K[i].zero?
  (N + 1).times do |j|
    ans[j] = DP[i][ans[j]]
  end
end

puts ans[1..]
