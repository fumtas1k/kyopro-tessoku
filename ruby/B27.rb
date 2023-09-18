# B27
# 最小公倍数
# 実行時間: 1s以内

A, B = gets.split.map(&:to_i)

# rubyにはlcmのメソッドがあるが今回は練習のためメソッドを自作する
# puts A.lcm B

def gcm(a, b)
  return b if a == 0
  gcm(b % a, a)
end

puts A * B / gcm(A, B)
