# A60
# スタック
# 実行時間: 1s以内

N = gets.to_i
A = gets.split.map(&:to_i)
stack = []
ans = []
A.each_with_index do |a, i|
  stack.pop while !stack.empty? && A[stack[-1]] <= a
  ans << (stack.empty? ? -1 : stack[-1] + 1)
  stack << i
end

puts ans.join(" ")
