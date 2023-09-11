# B45
# 不変量に着目する
# 1s以内

ABC = gets.split.map(&:to_i)

# 操作によって合計は変化しない
puts ABC.sum.zero? ? "Yes" : "No"
