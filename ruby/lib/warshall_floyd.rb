# ワーシャルフロイド法

class WarshallFloyd
  attr_accessor :dist, :second_last, :size

  def initialize(size)
    @size = size
    @dist = Array.new(size) { [Float::INFINITY] * size }
    @second_last = Array.new(size) { [_1] * size }
  end

  def add(from, to, cost)
    dist[from][to] = cost
  end

  def calc_sortest_dist
    size.times do |k|
      size.times do |i|
        size.times do |j|
          next if dist[i][j] <= dist[i][k] + dist[k][j]
          dist[i][j] = dist[i][k] + dist[k][j]
          second_last[i][j] = second_last[k][j]
        end
      end
    end
  end

  def get_shortest_dist(x, y)
    dist[x][y]
  end

  def get_shortest_path(x, y)
    return [] if get_shortest_dist(x, y) == Float::INFINITY
    transit = second_last[x][y]
    result = [y, transit]
    until transit == x
      transit = second_last[x][transit]
      result << transit
    end
    result.reverse
  end
end
