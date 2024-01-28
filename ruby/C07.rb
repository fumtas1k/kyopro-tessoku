# C07

N = gets.to_i
C = gets.split.map(&:to_i).sort
C_CSUM = C.reduce([0]) {|acc, c| acc << acc[-1] + c }

ans = []
gets.to_i.times do
  x  = gets.to_i
  idx = C_CSUM.bsearch_index { _1 > x } || N + 1
  ans << idx - 1
end

puts ans
