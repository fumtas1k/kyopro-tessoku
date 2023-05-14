# A65
# 木に対する動的計画法
# 1s以内

N = gets.to_i
G = Array.new(N + 1) { [] }
gets.split.map.with_index do |a, i|
  G[a.to_i] << i + 2
end

dp = [0] * (N + 1)
N.downto(1) do |i|
  G[i].each do|j|
    dp[i] += dp[j] + 1
  end
end

puts dp[1..].join(" ")
