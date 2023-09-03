# A08
# 二次元累積和
# 5s以内

H, W = gets.split.map(&:to_i)
X = Array.new(H) { gets.split.map(&:to_i) }
csum = Array.new(H + 1) { [0] * (W + 1) }

H.times do |i|
  W.times do |j|
    csum[i + 1][j + 1] += csum[i + 1][j] + csum[i][j + 1] - csum[i][j] + X[i][j]
  end
end

ans = gets.to_i.times.map do
  a, b, c, d = gets.split.map(&:to_i)
  csum[c][d] - csum[a - 1][d] - csum[c][b - 1] + csum[a - 1][b - 1]
end

puts ans
