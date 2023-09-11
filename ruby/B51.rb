# B51
# スタック
# 1s以内

S = gets.chomp.chars

r_brackets = []
ans = []
S.each_with_index do |s, i|
  case s
  when "("
    r_brackets << i + 1
  else
    ans << [r_brackets.pop, i + 1]
  end
end

puts ans.map { _1.join(" ") }
