# B36
# 偶奇
# 実行時間: 1s以内

N, K = gets.split.map(&:to_i)
S = gets.chomp.chars.map(&:to_i)

puts S.sum.even? == K.even? ? "Yes" : "No"
