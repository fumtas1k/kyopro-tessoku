# トポロジカルソート

class TopologicalSort
  attr_accessor :degree, :graph

  def initialize(size)
    @degree = Array.new(size + 1, 0)
    @graph = Array.new(size + 1) { [] }
  end

  def add(small, large)
    graph[small] << large
    degree[large] += 1
  end

  def sort
    deque = degree[1..].map.with_index {|d, i| i + 1 if d.zero? }.compact
    result = []
    cnt = 1
    until deque.empty?
      return [] unless deque.size == 1
      small = deque.shift
      result[small] = cnt
      cnt += 1
      graph[small].each do |large|
        degree[large] -= 1
        deque << large if degree[large].zero?
      end
    end
    return result
  end
end
