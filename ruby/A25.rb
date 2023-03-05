# A25
# 動的計画法
# Number of Routes
# 実行時間: 1s以内

start_time = Time.now

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  H, W = f.gets.split.map(&:to_i)
  C = Array.new(H) { f.gets.chomp.chars }
  dp = Array.new(H) { [0] * W }
  dp[0][0] = 1
  H.times do |i|
    W.times do |j|
      dp[i + 1][j] += dp[i][j] if i + 1 < H && C[i + 1][j] == "."
      dp[i][j + 1] += dp[i][j] if j + 1 < W && C[i][j + 1] == "."
    end
  end
  puts dp[-1][-1]
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
