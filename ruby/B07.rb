# B07
# いもす法
# 実行時間: 1s以内

T = gets.to_i
N = gets.to_i
LR = Array.new(N) { gets.split.map(&:to_i) }

cnts = Array.new(T + 1, 0)

LR.each do |l, r|
  cnts[l] += 1
  cnts[r] -= 1
end

T.times { cnts[_1 + 1] += cnts[_1] }

puts cnts[0, T]
