# A48
# 焼きなまし法
# Heuristic
# 実行時間: 1s以内

TRIAL_COUNT = 2 * 10 ** 5

def calc_dist(u, v)
  Math.sqrt(u.zip(v).sum { (_1[0] - _1[1]) ** 2 })
end

def calc_total_dist(order, dists)
  (order.size - 1).times.sum { dists[order[_1]][order[_1 + 1]] }
end

N = gets.to_i
XY = Array.new(N) { gets.split.map(&:to_i) }

dists = Array.new(N) { [0] * N }
N.times do |i|
  (i + 1).upto(N - 1) do |j|
    dists[i][j] = dists[j][i] = calc_dist(XY[i], XY[j])
  end
end

order = (N + 1).times.map { _1 % N }
current_dist = calc_total_dist(order, dists)

TRIAL_COUNT.times do |i|
  l, r = [rand(1 ... N), rand(1 ... N)].minmax
  new_dist = current_dist
  order_clone = order.dup
  order_clone[l .. r] = order_clone[l .. r].reverse
  new_dist -= calc_dist(XY[order[l - 1]], XY[order[l]])
  new_dist -= calc_dist(XY[order[r]], XY[order[r + 1]])
  new_dist += calc_dist(XY[order[l - 1]], XY[order[r]])
  new_dist += calc_dist(XY[order[l]], XY[order[r + 1]])

  t = 30 - 28.0 * i / TRIAL_COUNT
  prob = Math.exp([0, (current_dist - new_dist) / t].min)
  next if rand > prob
  current_dist = new_dist
  order = order_clone
end

puts order.map(&:next)
