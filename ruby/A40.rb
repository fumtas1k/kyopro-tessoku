# A40
# 個数を考える
# Triangle
# 実行時間: 1s以内

start_time = Time.now

module AddGroupingCountToArray
  refine Array do
    def grouping_count
      group_by(&:itself).map {|_, v| v.size }
    end
  end
end

def ncr(n, r)
  return 0 if n < r
  n.downto(n - r + 1).reduce(:*) / r.downto(1).reduce(:*)
end

using AddGroupingCountToArray

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N = f.gets.to_i
  A = f.gets.split.map(&:to_i)
  puts A.grouping_count.sum { ncr(_1, 3) }
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
