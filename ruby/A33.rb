# A33
# ニム
# 実行時間: 1s以内

start_time = Time.now

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N = f.gets.to_i
  A = f.gets.split.map(&:to_i)
  puts A.reduce(:^) == 0 ? "Second" : "First"
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
