# B39
# 貪欲法
# 二分探索法
# 優先度付きキュー
# 実行時間: 2s以内

N, D = gets.split.map(&:to_i)
TASKS = Array.new(D + 1) { [] }

N.times do
  x, y = gets.split.map(&:to_i)
  TASKS[x] << y
end

ans = 0
queue = []
1.upto(D) do |i|
  TASKS[i].each do |y|
    # priority_queueがrubyにはないので代替法
    idx = queue.bsearch_index { _1 >= y } || queue.size
    queue.insert(idx, y)
  end
  ans += queue.pop unless queue.empty?
end

puts ans
