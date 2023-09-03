# A09
# 二次元いもす法
# 5s以内

H, W, N = gets.split.map(&:to_i)
imos = Array.new(H + 1) { [0] * (W + 1) }

N.times do
  a, b, c, d = gets.split.map(&:to_i)
  imos[a - 1][b - 1] += 1
  imos[a - 1][d] -= 1
  imos[c][b - 1] -= 1
  imos[c][d] += 1
end

(H + 1).times do |i|
  W.times do |j|
    imos[i][j + 1] += imos[i][j]
  end
end

H.times do |i|
  (W + 1).times do |j|
    imos[i + 1][j] += imos[i][j]
  end
end

puts imos[...-1].map { _1[...-1].join(" ") }.join("\n")
