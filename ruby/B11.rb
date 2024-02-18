# B11
# 配列で二分探索

N = gets.to_i
A = gets.split.map(&:to_i).sort
Q = gets.to_i
X = Array.new(Q) { gets.to_i }

ans = X.map {|x| A.bsearch_index { _1 >= x } || N }
puts ans
