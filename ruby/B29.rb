# B29
# 
#

M = 10 ** 9 + 7
A, B = gets.split.map(&:to_i)

# rubyにはpowメソッドがあるが今回は練習のためメソッドを自作する
# puts A.pow(B, M)

def pow(x, n, mod)
  base = x
  exp = n
  result = 1
  while exp > 0
    if exp[0] == 1
      result = (result * base) % mod
    end
    base = (base * base) % mod
    exp /= 2
  end
  result
end

puts pow(A, B, M)
