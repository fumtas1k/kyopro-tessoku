# A39
# 貪欲法
# interval scheduling
# 実行時間: 2s以内

N = gets.to_i
LR = Array.new(N) { gets.split.map(&:to_i) }.sort_by(&:last)
now = cnt = 0
LR.each do |l, r|
  next if l < now
  now = r
  cnt += 1
end

puts cnt
