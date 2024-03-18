# A61
# グラフ
# 実行時間: 1s以内

N, M = gets.split.map(&:to_i)
G = Array.new(N + 1) { [] }
M.times do
  a, b = gets.split.map(&:to_i)
  G[a] << b
  G[b] << a
end

ans = []
G[1..].each.with_index(1) do |arr, i|
  ans << "#{i}: {#{arr.sort.join(", ")}}"
end
puts ans.join("\n")
