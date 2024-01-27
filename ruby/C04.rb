# C04

N = gets.to_i
max = Math.sqrt(N).to_i

ans = []
1.upto(max) do |i|
  next unless N % i == 0
  ans << i
  ans << N / i
end

puts ans.sort
