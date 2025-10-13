# A34
# grundy数
# 実行時間: 1s以内

MAX = 100_000
N, X, Y = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

grundy = [0] * (MAX + 1)
X.upto(MAX) do |i|
  # 遷移は2パターンしかないので、grundy数は[0, 1, 2]の3パターンしかない
  candidates = [0, 1, 2]
  candidates.delete(grundy[i - X])
  candidates.delete(grundy[i - Y]) if i >= Y
  grundy[i] = candidates[0]
end

puts A.map { grundy[_1] }.reduce(:^).zero? ? "Second" : "First"
