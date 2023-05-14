# A33
# ニム
# 実行時間: 1s以内

N = f.gets.to_i
A = f.gets.split.map(&:to_i)
puts A.reduce(:^) == 0 ? "Second" : "First"
