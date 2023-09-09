# B24
# 動的計画法
# 二分探索法
# 最長増加部分列
# 実行時間: 1s以内

N = gets.to_i
# xの最小順にし、yが同じ場合はyの最大順になるよう並び替えることで
# yの最長増加部分列として問題を解くことができる
XY = Array.new(N) { gets.split.map(&:to_i) }.sort_by { [_1[0], -_1[1]] }

lis = []

XY.each_with_index do |(_, y), i|
  lis << i if lis.empty?
  idx = lis.bsearch_index { XY[_1][1] >= y } || lis.size
  lis[idx] = i
end

puts lis.size
