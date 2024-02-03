# C15

N = gets.to_i
K = gets.to_i
LR = Array.new(N) { gets.split.map(&:to_i).then { [_1[0], _1[1] + K] } }

R_SORT = LR.sort_by(&:last)
MAX = R_SORT.last.last
L_SORT_REV = LR.sort_by(&:first).reverse

cnt_l = [0] * (MAX + 1)
cnt_r = [0] * (MAX + 1)
current = 0
cnt = 0
R_SORT.each do |l, r|
  next if current > l
  current = r
  cnt += 1
  cnt_l[current] = cnt
end

current = MAX
cnt = 0
L_SORT_REV.each do |l, r|
  next if current < r
  current = l
  cnt += 1
  cnt_r[current] = cnt
end

MAX.times do |i|
  cnt_l[i + 1] = [cnt_l[i], cnt_l[i + 1]].max
end
MAX.downto(1) do |i|
  cnt_r[i - 1] = [cnt_r[i - 1], cnt_r[i]].max
end

ans = []
LR.each do |l, r|
  ans << cnt_l[l] + 1 + cnt_r[r]
end

puts ans
