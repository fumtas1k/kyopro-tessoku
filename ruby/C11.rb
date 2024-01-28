# C11
# 動的計画法

N, M, K = gets.split.map(&:to_i)
AB = Array.new(M) { gets.split.map(&:to_i) }

def calc_score(l, r)
  AB.count do |a, b|
    l <= a && b <= r
  end
end

dp = Array.new(K + 1) { [0] * (N + 1) }

K.times do |i|
  i.upto(N) do |j|
    i.upto(j - 1) do |k|
      dp[i + 1][j] = [dp[i + 1][j], dp[i][k] + calc_score(k + 1, j)].max
    end
  end
end

puts dp[-1][-1]
