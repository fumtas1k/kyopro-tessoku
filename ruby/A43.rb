# A43
# 問題を言い換える
# 実行時間: 1s以内

start_time = Time.now

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N, L = f.gets.split.map(&:to_i)
  AB = Array.new(N) { f.gets.chomp.split }
end

puts AB.map { |a, b| b == "E" ? L - a.to_i : a.to_i }.max

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
