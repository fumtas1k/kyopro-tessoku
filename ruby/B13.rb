# B13
# しゃくとり法
# 1s以内

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

i = 0
ans = sum = 0
N.times do |j|
  while i < N && sum + A[i] <= K
    sum += A[i]
    i += 1
  end
  ans += i - j
  sum -= A[j]
end

puts ans
