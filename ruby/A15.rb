# A15
# 座標圧縮
# 2s以内

N = gets.to_i
A = gets.split.map(&:to_i)

DICT = A.uniq.sort.map.with_index {|a, i| [a, i + 1] }.to_h

puts A.map { DICT[_1] }.join(" ")
