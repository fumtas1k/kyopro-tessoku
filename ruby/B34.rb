# B34
# grundy数
# 実行時間: 1s以内

N, X, Y = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

# Aの最大値が10 ** 18であり、全てのgrundy数を求めることはできない
# X = 2, Y = 3　で固定した場合、grundy数は[0, 0, 1, 1, 2]の周期になる
grundy = [0, 0, 1, 1, 2]
puts A.map { grundy[_1 % 5] }.reduce(:^).zero? ? "Second" : "First"
