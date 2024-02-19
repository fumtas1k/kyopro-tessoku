# A33
# ニム
# 実行時間: 1s以内

N = gets.to_i
puts gets.split.map(&:to_i).reduce(:^).zero? ? "Second" : "First"
