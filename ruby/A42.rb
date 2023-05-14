# A42
# 固定(下限値)して全探索
# 実行時間: 1s以内

start_time = Time.now

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N, K = f.gets.split.map(&:to_i)
  AB = Array.new(N) { f.gets.split.map(&:to_i) }
end

def calc_assign_count(min_score_a, min_score_b)
  AB.count { |a, b| a.between?(min_score_a, min_score_a + K) && b.between?(min_score_b, min_score_b + K) }
end

ans = 0
(1..100 - K).each do |min_a|
  (1..100 - K).each do |min_b|
    ans = [ans, AB.count { |a, b| a.between?(min_a, min_a + K) && b.between?(min_b, min_b + K) }].max
  end
end
puts ans

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
