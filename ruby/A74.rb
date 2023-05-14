# A74
# 分解して考える
# 1s以内

row = []
column = []

N = gets.to_i
N.times do |i|
  p = gets.split.map(&:to_i)
  N.times do |j|
    next if p[j].zero?
    row[i] = column[j] = p[j]
  end
end

ans = 0
(N - 1).times do |i|
  (i + 1 ... N).each do |j|
    ans += 1 if row[i] > row[j]
    ans += 1 if column[i] > column[j]
  end
end

puts ans
