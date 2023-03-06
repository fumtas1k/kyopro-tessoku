# A30
# フェルマーの小定理
# Combination 組み合わせ
# 実行時間: 1s以内

start_time = Time.now

M = 10 ** 9 + 7

def npr(n, r, m)
  n.downto(n - r + 1).reduce {|acc, i| acc * i % m}
end

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N, R = f.gets.split.map(&:to_i)
  nr = npr(N, R, M)
  r1 = npr(R, R, M)

  puts nr * r1.pow(M - 2, M) % M
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
