# A38
# 上限値
# 実行時間: 1s以内

D, N = gets.split.map(&:to_i)
LRH = Array.new(N) { gets.split.map(&:to_i) }

lim = [24] * (D + 1)
lim[0] = 0
LRH.each do |l, r, h|
  (l .. r).each { lim[_1] = [lim[_1], h].min }
end
puts lim.sum
