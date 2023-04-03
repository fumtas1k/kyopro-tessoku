# A38
# 上限値
# 実行時間: 1s以内

start_time = Time.now

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  D, N = f.gets.split.map(&:to_i)
  LRH = Array.new(N) { f.gets.split.map(&:to_i) }
end

lim = [24] * (D + 1)
lim[0] = 0
LRH.each do |l, r, h|
  (l .. r).each { lim[_1] = [lim[_1], h].min }
end
puts lim.sum
puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
