# A24
# 動的計画法
# 二分探索法
# 最長増加部分列
# 実行時間: 1s以内

start_time = Time.now

# 戻り値の配列のi番目はarr[i]を最大とする最長増加部分列の長さ
def lis(arr)
  min_rights = []
  arr.reduce([]) do |len, a|
    idx = min_rights.bsearch_index { _1 >= a } || min_rights.size
    min_rights[idx] = a
    len << idx + 1
  end
end


File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N = f.gets.to_i
  A = f.gets.split.map(&:to_i)
  puts lis(A).max
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
