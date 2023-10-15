# B42
# 固定して全探索(場合分け)
# 実行時間: 1s以内

N = gets.to_i
AB = Array.new(N) { gets.split.map(&:to_i) }

# [A + B の最大値, A - Bの最大値, -A + Bの最大値, -A - Bの最大値]
C = [0] * 4
AB.each do |a, b|
  C[0] += a + b if a + b > 0
  C[1] += a - b if a - b > 0
  C[2] += -a + b if -a + b > 0
  C[3] += -a - b if -a - b > 0
end

puts C.max
