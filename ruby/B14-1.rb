# B14
# 二分探索法
# 半分全列挙
# BIT全列挙
# 1s以内

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

def sum_pattern(arr)
  result = (1 << arr.size).times.map do |bit|
    arr.filter.with_index { |_, i| bit[i].zero? }.sum
  end.uniq.sort
end

half = N / 2

sums1 = sum_pattern(A[0, half])
sums2 = sum_pattern(A[half, N - half])

sums1.each do |sum1|
  if sums2.bsearch { K - (sum1 + _1) }
    puts "Yes"
    exit
  end
end

puts "No"
