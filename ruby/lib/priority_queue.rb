# 優先度付きキュー

class PriorityQueue
  private attr_accessor :heap, :ope

  def initialize(arr = [], &block)
    @heap = []
    @ope = block || proc { |x, y| x <= y }
    push_all(arr)
  end

  def size = heap.size

  def first = heap.first

  def empty? = heap.empty?

  def <<(x)
    i = size
    while i > 0
      parent_idx = (i - 1) / 2
      break if ope.call(heap[parent_idx], x)
      heap[i] = heap[parent_idx]
      i = parent_idx
    end
    heap[i] = x
  end

  def push_all(arr)
    arr.each { self << _1 }
  end

  def shift
    return if empty?
    min = first
    x = heap.pop
    unless empty?
      i = 0
      while (child_idx1 = 2 * i + 1) < size
        child_idx2 = child_idx1 + 1
        if child_idx2 < size && !ope.call(heap[child_idx1], heap[child_idx2])
          child_idx1 = child_idx2
        end
        break if ope.call(x, heap[child_idx1])
        heap[i] = heap[child_idx1]
        i = child_idx1
      end
      heap[i] = x
    end
    min
  end
end
