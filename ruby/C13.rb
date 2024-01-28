# C13
# HASH

M = 10 ** 9 + 7
N, P = gets.split.map(&:to_i)
A = gets.split.map(&:to_i).map { _1 % M }.tally

ans = 0
A.each do |i, cnt|
  next if i.zero?
  j = P * i.pow(M - 2, M) % M
  next if i > j || (i * j) % M != P || A[j].nil?
  ans += i == j ? cnt * (cnt - 1) / 2 :  cnt * A[j]
end

if P.zero? && A[0]
  ans += A[0] * (A[0] - 1) / 2
  ans += A[0] * (N - A[0])
end

puts ans
