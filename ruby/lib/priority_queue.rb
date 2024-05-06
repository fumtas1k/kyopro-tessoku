# 優先度付きキュー

class PriorityQueue
  attr_reader :heap, :ope

  def initialize(arr = [], &block)
    @heap = arr
    @ope = block || proc { |x, y| x < y }
    heapify
  end

  def size = heap.size

  def first = heap.first

  def empty? = heap.empty?

  def <<(item)
    heap << item
    shift_down(0, heap.size - 1)
    self
  end

  def push_all(arr)
    arr.each { self << _1 }
    self
  end

  # 取り出す
  def shift
    last = heap.pop
    return last if heap.empty?
    res_item = heap[0]
    heap[0] = last
    shift_up(0)
    res_item
  end
  alias pop shift

  private
  def heapify
    (heap.size / 2 - 1).downto(0) { shift_up(_1) }
  end

  def shift_up(idx)
    start_idx = idx
    item = heap[idx]
    while (child_idx1 = 2 * idx + 1) < heap.size
      child_idx2 = child_idx1 + 1
      if child_idx2 < heap.size && !ope.call(heap[child_idx1], heap[child_idx2])
        child_idx1 = child_idx2
      end
      heap[idx] = heap[child_idx1]
      idx = child_idx1
    end
    heap[idx] = item

    # itemとの優先度比較をせずに、itemをheap.size - 1まで移動させている
    # itemを正しい位置に移動させるためshift_downを呼ぶ
    shift_down(start_idx, idx)
  end

  def shift_down(start_idx, idx)
    item = heap[idx]
    while idx > start_idx
      parent_idx = (idx - 1) >> 1
      break if ope.call(heap[parent_idx], item)
      heap[idx] = heap[parent_idx]
      idx = parent_idx
    end
    heap[idx] = item
  end
end
