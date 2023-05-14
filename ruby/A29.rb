# A29
# 累乗
# 実行時間: 1s以内

M = 10 ** 9 + 7

def power(a, b, m)
  exp = b
  base = a
  result = 1
  while exp > 0
    if exp % 2 == 1
      result *= base
      result %= m
    end
    exp /= 2
    base *= base
    base %= m
  end
  result
end

def pow(a, b, m)
  result = 1
  base = a
  b.bit_length.times do |i|
    if b >> i & 1 == 1
      result *= base
      result %= m
    end
    base *= base
    base %= m
  end
  result
end

a, b = gets.split.map(&:to_i)
# puts power(a, b, M)
puts pow(a, b, M)
# puts a.pow(b, M)
