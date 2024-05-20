# A21
# 区間DP
# 後ろから考える
# 1s以内

N = gets.to_i
PA = Array.new(N) { gets.split.map(&:to_i).then { [_1[0] - 1, _1[1]] } }
dp = Array.new(N) { Array.new(N, 0) }

N.times do |dl|
  0.upto(N - dl - 1) do |l|
    r = l + dl
    if l > 0
      pl, al = PA[l - 1]
      score_l = pl.between?(l, r) ? al : 0
      dp[l - 1][r] = [dp[l - 1][r], dp[l][r] + score_l].max
    end

    if r < N - 1
      pr, ar = PA[r + 1]
      score_r = pr.between?(l, r) ? ar : 0
      dp[l][r + 1] = [dp[l][r + 1], dp[l][r] + score_r].max
    end
  end
end

puts dp[0][-1]
