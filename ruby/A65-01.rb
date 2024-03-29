# A65
# 深さ優先対策
# Depth First Search(DFS)
# 1s以内

N = gets.to_i
G = Array.new(N + 1) { [] }
gets.split.map.with_index do |a, i|
  G[a.to_i] << i + 2
end

@ans = [0] * (N + 1)
def dfs(pos)
  G[pos].each do |i|
    @ans[pos] += dfs(i) + 1
  end
  @ans[pos]
end

dfs(1)

puts @ans[1..].join(" ")
