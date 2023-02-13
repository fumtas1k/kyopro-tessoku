class MinHeap
  attr_accessor :heap

  def initialize
    @heap = [-Float::INFINITY]
  end

  def size
    @heap.size - 1
  end

  def parent_index(index)
    index / 2
  end

  def left_child_index(index)
    index * 2
  end

  def right_child_index(index)
    index * 2 + 1
  end

  def min_child_index(index)
    return  left_child_index(index) if right_child_index(index) > size
    heap[left_child_index(index)] <= heap[right_child_index(index)] ? left_child_index(index) : right_child_index(index)
  end

  def swap(index1, index2)
    heap[index1], heap[index2] = heap[index2], heap[index1]
  end

  def heapify_up(index)
    while (parent = parent_index(index)) > 0
      if heap[index] < heap[parent]
        swap(index, parent)
      end
      index = parent
    end
  end

  def heapify_down(index)
    while (child = left_child_index(index)) <= size
      min_child = min_child_index(index)
      if heap[index] > heap[min_child]
        swap(index, min_child)
      end
      index = min_child
    end
  end

  def push(value)
    heap << value
    heapify_up(size)
  end

  def shift
    return if size.zero?
    root = heap[1]
    data = heap.pop
    return root if size.zero?
    heap[1] = data
    heapify_down(1)
    root
  end

  def first
    return if size.zero?
    heap[1]
  end

  def to_s
    return if size.zero?
    heap[1..].to_s
  end
end
