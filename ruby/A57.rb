# A57
# ダブリング
# 実行時間: 2s以内

start_time = Time.now
# 10 ^ 9 < 2 ^ 30
MAX = 30

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N, Q = f.gets.split.map(&:to_i)
  A = [0] + f.gets.split.map(&:to_i)
  XY = Array.new(Q) { f.gets.split.map(&:to_i) }
end

dp = Array.new(MAX) { [0] * (N + 1) }
dp[0] = A.clone

(1 ... MAX).each do |i|
  (1 .. N).each do |j|
    dp[i][j] = dp[i - 1][dp[i - 1][j]]
  end
end

XY.each do |x, y|
  pos = x
  MAX.times do |i|
    next if (y >> i) & 1 == 0
    pos = dp[i][pos]
  end
  puts pos
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
