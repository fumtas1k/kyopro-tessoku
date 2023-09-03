# A11
# 二分探索法
# 1s以内

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

def calc_cnt(t)
  A.map { t / _1 }.sum
end

puts (1 .. 10 ** 9).bsearch { calc_cnt(_1) >= K }
