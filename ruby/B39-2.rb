# B39
# 貪欲法
# 二分探索法
# 優先度付キュー
# 実行時間: 2s以内

# Priority Queue
# Reference: https://github.com/python/cpython/blob/main/Lib/heapq.py
class PriorityQueue
  # By default, the priority queue returns the maximum element first.
  # If a block is given, the priority between the elements is determined with it.
  # For example, the following block is given, the priority queue returns the minimum element first.
  # `PriorityQueue.new { |x, y| x < y }`
  #
  # A heap is an array for which a[k] <= a[2*k+1] and a[k] <= a[2*k+2] for all k, counting elements from 0.
  def initialize(array = [], &comp)
    @heap = array
    @comp = comp || proc { |x, y| x > y }
    heapify
  end

  def self.max(array)
    new(array)
  end

  def self.min(array)
    new(array){ |x, y| x < y }
  end

  def self.[](*array, &comp)
    new(array, &comp)
  end

  attr_reader :heap
  alias to_a heap

  # Push new element to the heap.
  def push(item)
    shift_down(0, @heap.push(item).size - 1)
    self
  end

  alias << push
  alias append push

  # Pop the element with the highest priority.
  def pop
    latest = @heap.pop
    return latest if empty?

    ret_item = heap[0]
    heap[0] = latest
    shift_up(0)
    ret_item
  end

  # Get the element with the highest priority.
  def get
    @heap[0]
  end

  alias top get
  alias first get

  # Returns true if the heap is empty.
  def empty?
    @heap.empty?
  end

  def size
    @heap.size
  end

  def to_s
    "<#{self.class}: @heap:(#{heap.join(', ')}), @comp:<#{@comp.class} #{@comp.source_location.join(':')}>>"
  end

  private

  def heapify
    (@heap.size / 2 - 1).downto(0) { |i| shift_up(i) }
  end

  def shift_up(pos)
    end_pos = @heap.size
    start_pos = pos
    new_item = @heap[pos]
    left_child_pos = 2 * pos + 1

    while left_child_pos < end_pos
      right_child_pos = left_child_pos + 1
      if right_child_pos < end_pos && @comp.call(@heap[right_child_pos], @heap[left_child_pos])
        left_child_pos = right_child_pos
      end
      # Move the higher priority child up.
      @heap[pos] = @heap[left_child_pos]
      pos = left_child_pos
      left_child_pos = 2 * pos + 1
    end
    @heap[pos] = new_item
    shift_down(start_pos, pos)
  end

  def shift_down(star_pos, pos)
    new_item = @heap[pos]
    while pos > star_pos
      parent_pos = (pos - 1) >> 1
      parent = @heap[parent_pos]
      break if @comp.call(parent, new_item)

      @heap[pos] = parent
      pos = parent_pos
    end
    @heap[pos] = new_item
  end
end

N, D = gets.split.map(&:to_i)
TASKS = Array.new(D + 1) { [] }

N.times do
  x, y = gets.split.map(&:to_i)
  TASKS[x] << y
end

ans = 0
queue = PriorityQueue.max([])
1.upto(D) do |i|
  TASKS[i].each do |y|
    queue << y
  end
  ans += queue.pop unless queue.empty?
end

puts ans
