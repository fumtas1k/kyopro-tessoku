# A21
# 区間DP
# 1s以内

N = gets.to_i
PA = Array.new(N) { gets.split.map(&:to_i).then { [_1[0] - 1, _1[1]]} }

dp = Array.new(N) { Array.new(N, 0) }

(N - 2).downto(0) do |dl|
  0.upto(N - dl - 1) do |l|
    r = l + dl

    if l > 0
      score1 = PA[l - 1][0].between?(l, r) ? PA[l - 1][1] : 0
      dp[l][r] = [dp[l][r], dp[l - 1][r] + score1].max
    end
    if r < N - 1
      score2 = PA[r + 1][0].between?(l, r) ? PA[r + 1][1] : 0
      dp[l][r] = [dp[l][r], dp[l][r + 1] + score2].max
    end
  end
end

puts N.times.map { dp[_1][_1] }.max
