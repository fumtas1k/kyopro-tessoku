# A46
# 貪欲法
# Heuristic
# 実行時間: 1s以内

def measure_dist(u, v)
  Math.sqrt(u.zip(v).sum { (_1[0] - _1[1]) ** 2 })
end

def nearest(u, dists, visited)
  visited.size.times.filter { !visited[_1] }.min_by { dists[u][_1] }
end

N = gets.to_i
XY = Array.new(N) { gets.split.map(&:to_i) }

visited = [true] + [false] * N
dists = Array.new(N + 1) { [Float::INFINITY] * (N + 1) }
N.times do |i|
  (i ... N).each do |j|
    dists[i + 1][j + 1] = dists[j + 1][i + 1] = measure_dist(XY[i], XY[j])
  end
end

ans = [1]
visited[ans[-1]] = true
until visited.all?
  ans << nearest(ans[-1], dists, visited)
  visited[ans[-1]] = true
end
ans << 1
puts ans
