# C18
# 区間DP

N = gets.to_i
A = gets.split.map(&:to_i)

dp = Array.new(2 * N) { [Float::INFINITY] * (2 * N) }

(2 * N - 1).times do |i|
  dp[i][i + 1] = (A[i] - A[i + 1]).abs
end

2.upto(2 * N - 1) do |dl|
  0.upto(2 * N - 1 - dl) do |l|
    r = l + dl
    # 最後にA[l]とA[r]を削除する
    dp[l][r] = [dp[l][r], dp[l + 1][r - 1] + (A[l] - A[r]).abs].min
    l.upto(r - 1) do |m|
      # 2つの区間に分割して考える
      dp[l][r] = [dp[l][r], dp[l][m] + dp[m + 1][r]].min
    end
  end
end

puts dp[0][-1]
