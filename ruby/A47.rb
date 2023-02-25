# A47
# 局所探索法
# Heuristic
# 実行時間: 1s以内

start_time = Time.now

TRIAL_COUNT = 3 * 10 ** 4

def measure_dist(u, v)
  Math.sqrt(u.zip(v).sum { (_1[0] - _1[1]) ** 2 })
end

def measure_total_dist(order, dists)
  (order.size - 1).times.sum { dists[order[_1]][order[_1 + 1]] }
end

def nearest(u, dists, visited)
  visited.size.times.filter { !visited[_1] }.min_by { dists[u][_1] }
end

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N = f.gets.to_i
  XY = Array.new(N) { f.gets.split.map(&:to_i) }

  dists = Array.new(N + 1) { [Float::INFINITY] * (N + 1) }
  N.times do |i|
    (i ... N).each do |j|
      dists[i + 1][j + 1] = dists[j + 1][i + 1] = measure_dist(XY[i], XY[j])
    end
  end

  order = Array.new(N) { _1 + 1 } + [1]

  current_dist = measure_total_dist(order, dists)

  TRIAL_COUNT.times do |i|
    l, r = [rand(1 ... N), rand(1 ... N)].minmax
    order_clone = order.dup
    order_clone[l .. r] = order_clone[l .. r].reverse
    new_dist = measure_total_dist(order_clone, dists)
    if (current_dist >= new_dist)
      current_dist = new_dist
      order = order_clone
    end
  end
  puts order
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
