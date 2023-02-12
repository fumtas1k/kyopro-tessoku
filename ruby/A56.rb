# 56
# ハッシュ
# 実行時間: 2s以内

start_time = Time.now

File.open("question/A56.txt", "r") do |f|
  N, Q = f.gets.split.map(&:to_i)
  S = f.gets.chomp
  ABCD = Array.new(Q) { f.gets.split.map { _1.to_i - 1} }
end

ABCD.each do |a, b, c, d|
  p
  puts S[a .. b].hash == S[c .. d].hash ? "Yes" : "No"
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
