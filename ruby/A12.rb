# A11
# 二分探索法
# 1s以内

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
def copy_cnt(time) = A.sum { time / _1 }

puts (1 .. 10 ** 9).bsearch { copy_cnt(_1) >= K }
