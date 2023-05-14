# A72
# bit全探索
# 1s 以内

H, W, K = gets.split.map(&:to_i)
C = Array.new(H) { gets.chomp.chars.map { _1 == "#" ? 1 : 0 } }

ans = []
(1 << H).times do |bit|
  c = []
  k = 0
  H.times do |i|
    if (bit >> i) & 1 == 0
      c << C[i]
    else
      c << [1] * W
      k += 1
    end
  end
  next if k > K
  ans << c.flatten.sum + c.transpose.map { H - _1.sum }.sort.reverse.take(K - k).sum
end

puts ans.max
