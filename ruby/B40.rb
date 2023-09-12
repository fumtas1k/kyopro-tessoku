# B40
# 個数を考える
# 実行時間: 1s以内

gets
A = gets.split.map(&:to_i).map { _1 % 100 }.tally
A.default = 0

ans = (100 / 2 + 1).times.sum do |i|
  j = (100 - i) % 100
  if i == j
    A[i] * (A[i] - 1) / 2
  else
    A[i] * A[j]
  end
end

puts ans
