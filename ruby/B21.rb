# A21
# 区間DP
# 1s以内

N = gets.to_i
S = gets.chomp.chars

dp = Array.new(N) { [1] * N }
(N - 1).times do |i|
  dp[i][i + 1] = 2 if S[i] == S[i + 1]
end

2.upto(N - 1) do |dl|
  0.upto(N - dl - 1) do |l|
    r = l + dl
    dp[l][r] = [dp[l][r - 1], dp[l + 1][r]].max
    dp[l][r] = [dp[l][r], dp[l + 1][r - 1] + 2].max if S[l] == S[r]
  end
end

puts dp[0][-1]
