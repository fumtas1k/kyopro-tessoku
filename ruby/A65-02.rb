# A65
# 木に対する動的計画法
# 1s以内

start_time = Time.now

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N = f.gets.to_i
  G = Array.new(N + 1) { [] }
  f.gets.split.map.with_index do |a, i|
    G[a.to_i] << i + 2
  end
end

dp = [0] * (N + 1)
N.downto(1) do |i|
  G[i].each do|j|
    dp[i] += dp[j] + 1
  end
end

puts dp[1..].join(" ")

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
