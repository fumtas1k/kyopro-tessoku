# C03
# 累積和

D = gets.to_i
X = gets.to_i
A = Array.new(D - 1) { gets.to_i }
Q = gets.to_i
ST = Array.new(Q) { gets.split.map(&:to_i).map(&:pred) }

B = A.reduce([X]) {|acc, a| acc << acc[-1] + a }

ans = []
ST.each do |s, t|
  ans << if B[s] > B[t]
    s + 1
  elsif B[s] == B[t]
    "Same"
  else
    t + 1
  end
end

puts ans
