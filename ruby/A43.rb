# A43
# 問題を言い換える
# 実行時間: 1s以内

N, L = gets.split.map(&:to_i)
AB = Array.new(N) { gets.chomp.split }

puts AB.map { |a, b| b == "E" ? L - a.to_i : a.to_i }.max
