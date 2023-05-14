# A44
# データの持ち方を工夫する
# 実行時間: 1s以内

start_time = Time.now

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N, Q = f.gets.split.map(&:to_i)
  QUERY = Array.new(Q) { f.gets.split.map(&:to_i) }
end

A = [*0 .. N]
rev = false
QUERY.each do |q|
  case q[0]
  when 1
    if rev
      A[N - q[1] + 1] = q[2]
    else
      A[q[1]] = q[2]
    end
  when 2
    rev = !rev
  when 3
    puts rev ? A[N - q[1] + 1] : A[q[1]]
  end
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
