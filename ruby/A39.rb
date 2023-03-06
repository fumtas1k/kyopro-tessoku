# A39
# 貪欲法
# interval scheduling
# 実行時間: 2s以内

start_time = Time.now

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N = f.gets.to_i
  LR = Array.new(N) { f.gets.split.map(&:to_i) }.sort_by(&:last)
  now = cnt = 0
  LR.each do |l, r|
    next if l < now
    now = r
    cnt += 1
  end

  puts cnt
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
