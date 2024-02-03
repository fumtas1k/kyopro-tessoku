# C11

N, k = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)
seats = A.map.with_index {|a, i| [a, 1, i] }.sort_by(&:first).reverse

while k > 0
  _, cnt, i = seats.shift
  seat = [A[i].to_f / (cnt + 1), cnt + 1, i]
  idx = seats.bsearch_index { _1.first <= seat.first } || seats.size
  seats.insert(idx, seat)
  k -= 1
end

puts seats.sort_by(&:last).map { _1[1].pred }.join(" ")
