# A37
# 足された回数
# 1s以内

N, M, B = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
C = gets.split.map(&:to_i)

puts M * A.sum + N * C.sum + (N * M) * B
