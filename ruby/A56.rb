# 56
# ハッシュ
# 実行時間: 2s以内

N, Q = gets.split.map(&:to_i)
S = gets.chomp
ABCD = Array.new(Q) { gets.split.map { _1.to_i - 1} }

ABCD.each do |a, b, c, d|
  p
  puts S[a .. b].hash == S[c .. d].hash ? "Yes" : "No"
end
