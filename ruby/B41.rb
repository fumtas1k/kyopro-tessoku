# A41
# 後ろから考える
# Reverse of Euclid
# 実行時間: 10s以内

x, y = gets.split.map(&:to_i)

ans = []
until x == 1 && y == 1
  ans << [x, y]
  x > y ? x -= y : y -= x
end

puts ans.size
puts ans.reverse.map { _1.join(" ") }.join("\n") unless ans.size.zero?
