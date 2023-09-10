# B14
# 二分探索法
# 半分全列挙
# BIT全列挙
# 1s以内

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

def sum_pattern(arr)
  result = []
  (1 << arr.size).times do |bits|
    selected_sum = 0
    arr.size.times do |i|
      selected_sum += arr[i] unless bits[i].zero?
    end
    result << selected_sum
  end
  result.uniq.sort
end

half = N / 2
B = sum_pattern(A[0, half])
C = sum_pattern(A[half ... N])

B.each do |b|
  next unless C.bsearch { K - (b + _1) }
  puts "Yes"
  exit
end

puts "No"
