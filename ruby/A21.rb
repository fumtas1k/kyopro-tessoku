# A21
# 区間DP
# 1s以内

start_time = Time.now

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N = f.gets.to_i
  PA = [[]] + Array.new(N) { f.gets.split.map(&:to_i) }
end
dp = Array.new(N + 1) { [0] * (N + 1) }

(N - 2).downto(0) do |len|
  1.upto(N - len) do |l|
    r = l + len
    score1 = (l > 1 && PA[l - 1][0].between?(l, r)) ? PA[l - 1][1] : 0
    score2 = (r < N && PA[r + 1][0].between?(l, r)) ? PA[r + 1][1] : 0

    if l > 1
      dp[l][r] = [dp[l][r], dp[l - 1][r] + score1].max
    end
    if r < N
      dp[l][r] = [dp[l][r], dp[l][r + 1] + score2].max
    end
  end
end

puts [*1 .. N].map { dp[_1][_1] }.max

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
