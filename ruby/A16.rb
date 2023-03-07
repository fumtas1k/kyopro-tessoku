# A16
# 動的計画法
# 実行時間: 1s以内

start_time = Time.now

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N = f.gets.to_i
  A = [Float::INFINITY] * 2 + f.gets.split.map(&:to_i)
  B = [Float::INFINITY] * 3 + f.gets.split.map(&:to_i)
  dp = [Float::INFINITY] * (N + 1)
  dp[1 .. 2] = [0, A[2]]

  3.upto(N) do |i|
    dp[i] = [dp[i - 1] + A[i], dp[i - 2] + B[i]].min
  end

  puts dp[-1]
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
