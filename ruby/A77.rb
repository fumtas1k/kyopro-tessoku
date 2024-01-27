# A77
# 貪欲法
# 二分探索法
# 2s以内

N, L = gets.split.map(&:to_i)
K = gets.to_i
A = gets.split.map(&:to_i)

def cuttable?(min_size)
  cutlines = [0]
  A.each do |a|
    next if a - cutlines[-1] < min_size || L - a < min_size
    cutlines << a
  end
  cutlines.size >= K + 1
end

left = 0
right = L + 1
while right - left > 1
  mid = (left + right) / 2
  cuttable?(mid) ? left = mid : right = mid
end

puts left
