# A34
# grundy数
# 実行時間: 1s以内

N, X, Y = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
MAX = A.max
grundy = [0] * (MAX + 1)

1.upto(MAX) do |i|
  # 遷移は2パターンしかないので、grundy数は[0, 1, 2]の3パターンしかない
  transit = [false] * 3
  transit[grundy[i - X]] = true if i >= X
  transit[grundy[i - Y]] = true if i >= Y
  3.times do |j|
    unless transit[j]
      grundy[i] = j
      break
    end
  end
end

puts A.map { grundy[_1] }.reduce(:^).zero? ? "Second" : "First"
