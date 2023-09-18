# B28
# フィボナッチ数列
# 実行時間: 1s以内

M = 10 ** 9 + 7
A = [1] * 3

N = gets.to_i
3.upto(N) do |i|
  A[i] = (A[i - 1] + A[i - 2]) % M
end

puts A[N]
