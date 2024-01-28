# C06

N = gets.to_i

ans = []
N.times do |i|
  ans << [i + 1, (i + 1) % N + 1]
end

puts ans.size
ans.each { puts _1.join(" ") }
