# A13
# しゃくとり法
# 1s以内

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N, K = f.gets.split.map(&:to_i)
  A = f.gets.split.map(&:to_i)
end

r = 0
ans = 0
N.times do |l|
  next if A[r] - A[l] > K
  while r < N - 1 && A[r + 1] - A[l] <= K
    r += 1
  end
  ans += r - l
end

puts ans
