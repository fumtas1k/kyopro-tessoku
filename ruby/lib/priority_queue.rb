# 優先度付きキュー
# 要素の配列の1番目を元にheapを構成する

class PriorityQueue

  def initialize
    @queue = [[Float::INFINITY]]
  end

  def self.from(list)
    instance = PriorityQueue.new
    instance.push_all(list)
    instance
  end

  def queue
    @queue[1..]
  end

  def size
    @queue.size - 1
  end

  def push(arr)
    @queue << arr
    queue_up(size)
  end

  def push_all(list)
    list.each { push(_1) }
  end

  def shift
    return if size.zero?
    root = @queue[1]
    data = @queue.pop
    return root if size.zero?
    @queue[1] = data
    queue_down(1)
    root
  end

  def first
    return if size.zero?
    @queue[1]
  end

  def to_s
    queue.to_s
  end

  private

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
    left, right = left_child_index(index), right_child_index(index)
    return left if right > size
    @queue[left].first <= @queue[right].first ? left : right
  end

  def swap(index1, index2)
    @queue[index1], @queue[index2] = @queue[index2], @queue[index1]
  end

  def queue_up(index)
    while (parent = parent_index(index)) > 0
      if @queue[index].first < @queue[parent].first
        swap(index, parent)
      end
      index = parent
    end
  end

  def queue_down(index)
    while (child = left_child_index(index)) <= size
      min_child = min_child_index(index)
      if @queue[index].first > @queue[min_child].first
        swap(index, min_child)
      end
      index = min_child
    end
  end
end
