class Trie
  Node = Struct.new(:child, :is_end, :value, :count, keyword_init: true) {
    def self.default
      new(child: Hash.new, is_end: false, value: nil, count: 0)
    end
  }

  attr_reader :root

  def initialize
    @root = Node.default
  end

  def insert(word, value = nil)
    node = root
    word.chars.each_with_index do |c, i|
      unless node.child[c]
        node.child[c] = Node.default
      end
      node.count += 1
      node = node.child[c]
    end
      node.count += 1
      node.value = value
      node.is_end = true
  end

  def search(word)
    ptr = root
    word.chars.each do |c|
      return false unless ptr.child[c]
      ptr = ptr.child[c]
    end
    ptr.is_end
  end

  def erase(word)
    word_chars = word.chars
    ptr = root
    stack = [ptr]
    word_chars.each do |c|
      return unless ptr.child[c]
      ptr = ptr.child[c]
      stack << ptr
    end
    return unless ptr.is_end

    unless ptr.child.empty?
      ptr.is_end = false
      ptr.value = nil
      ptr.count -= 1
      return
    end

    stack.pop
    word_chars.reverse.each do |c|
      ptr = stack.pop
      ptr.count -= ptr.child[c].count
      ptr.child[c] = nil
      return if ptr.is_end || !ptr.child.empty?
    end
  end

  def count_prefix(word)
    ptr = root
    word.chars.each do |c|
      return 0 unless ptr.child[c]
      ptr = ptr.child[c]
    end
    ptr.count
  end

  def get_value(key)
    ptr = root
    key.chars.each do |k|
      return unless ptr.child[k]
      ptr = ptr.child[k]
    end
    ptr.value
  end

  def get_lcp(word)
    ptr = root
    res = []
    word.chars.each_with_index do |k, i|
      break unless ptr.child[k]
      res << k
      ptr = ptr.child[k]
    end
    return res.join
  end
end
