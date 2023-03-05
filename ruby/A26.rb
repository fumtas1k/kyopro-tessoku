# A26
# 素数判定
# 実行時間: 1s以内

start_time = Time.now

def prime?(x)
  return false if x < 2
  !2.upto(Math.sqrt(x).to_i).any? { x % _1 == 0 }
end

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  Q = f.gets.to_i
  X = Array.new(Q) { f.gets.to_i }
  X.each { puts prime?(_1) ? "Yes" : "No" }
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
