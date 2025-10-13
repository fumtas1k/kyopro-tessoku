# A36
# 偶奇
# 実行時間: 1s以内

N, K = gets.split.map(&:to_i)

puts K.even? && (N - 1) * 2 <= K ? "Yes" : "No"

