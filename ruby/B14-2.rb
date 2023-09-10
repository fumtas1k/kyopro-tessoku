# B14
# 深さ優先探索
# DFS
# 1s以内

N, K = gets.split.map(&:to_i)
A = gets.split.map(&:to_i)

def dfs(pos = 0, sum = 0)
  if sum == K
    puts "Yes"
    exit
  end
  return if sum > K || pos == N
  dfs(pos + 1, sum + A[pos])
  dfs(pos + 1, sum)
end

dfs
puts "No"
