# A11
# 二分探索法
# 1s以内

N, X = gets.split.map(&:to_i)
A = gets.split.map(&:to_i).sort

puts A.bsearch_index { X <=> _1 } + 1
