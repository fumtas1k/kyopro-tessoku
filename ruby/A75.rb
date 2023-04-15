# A75
# 貪欲法
# 動的計画法
# 1s以内


File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N = f.gets.to_i
  TD = Array.new(N) { f.gets.split.map(&:to_i) }.sort_by { _1[1] }
end
max_d = TD[-1][-1]
dp = Array.new(N + 1) { [0] * (max_d + 1) }

TD.each_with_index do |(t, d), i|
  (max_d + 1).times do |j|
    dp[i + 1][j] = dp[i][j]
    dp[i + 1][j] = [dp[i + 1][j], dp[i][j - t] + 1].max if j.between?(t, d)
  end
end

puts dp[-1].max
