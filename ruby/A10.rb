# A10
# 累積和
# 1s以内

N = gets.to_i
A = gets.split.map(&:to_i)
D = gets.to_i
LR = Array.new(D) { gets.split.map(&:to_i).map(&:pred) }

l_max = A.reduce([0]) {|acc, i| acc << [acc[-1], i].max }
r_max = A.reverse.reduce([0]) {|acc, i| acc << [acc[-1], i].max }.reverse

ans = []
LR.each do |l, r|
  ans << [l_max[l], r_max[r + 1]].max
end

puts ans
