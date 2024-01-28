# C08
# 全探索

def match?(check_num, rank, win_num)
  cnt_rank = check_num.zip(win_num).count { _1[0] != _1[1] } + 1
  rank == (cnt_rank > 3 ? 3 : cnt_rank)
end

N = gets.to_i
ST = Array.new(N) { gets.chomp.split.then { [_1[0].chars, _1[1].to_i] } }

ans = []
10000.times do |i|
  win_num = i.to_s.rjust(4, "0").chars
  ans << win_num.join if ST.all? { match?(*_1, win_num) }
end

puts ans.size == 1 ? ans.first : "Can't Solve"
