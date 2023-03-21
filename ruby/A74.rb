# A74
# 分解して考える
# 1s以内

row = []
column = []
File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N = f.gets.to_i
  N.times do |i|
    p = f.gets.split.map(&:to_i)
    N.times do |j|
      next if p[j].zero?
      row[i] = column[j] = p[j]
    end
  end
end

ans = 0
(N - 1).times do |i|
  (i + 1 ... N).each do |j|
    ans += 1 if row[i] > row[j]
    ans += 1 if column[i] > column[j]
  end
end

puts ans
