class Trie
  Node = Struct.new(:child, :is_end, :value, :count, keyword_init: true) {
    def self.default
      new(child: Array.new(26), is_end: false, value: nil, count: 0)
    end
  }

  attr_reader :root

  def initialize
    @root = Node.default
  end

  def insert(word, value = nil)
    node = root
    word.chars.each_with_index do |c, i|
      num = to_num(c)
      unless node.child[num]
        node.child[num] = Node.default
      end
      node.count += 1
      node = node.child[num]
    end
      node.count += 1
      node.value = value
      node.is_end = true
  end

  def search(word)
    ptr = root
    word.chars.each do |c|
      num = to_num(c)
      return false unless ptr.child[num]
      ptr = ptr.child[num]
    end
    ptr.is_end
  end

  def erase(word)
    word_chars = word.chars
    ptr = root
    stack = [ptr]
    word_chars.each do |c|
      num = to_num(c)
      return unless ptr.child[num]
      ptr = ptr.child[num]
      stack << ptr
    end
    return unless ptr.is_end

    unless ptr.child.all? { _1.nil? }
      ptr.is_end = false
      ptr.value = nil
      ptr.count -= 1
      return
    end

    stack.pop
    word_chars.reverse.each do |c|
      num = to_num(c)
      ptr = stack.pop
      ptr.count -= ptr.child[num].count
      ptr.child[num] = nil
      return if ptr.is_end || !ptr.child.all? { _1.nil? }
    end
  end

  def count_prefix(word)
    ptr = root
    word.chars.each do |c|
      num = to_num(c)
      return 0 unless ptr.child[num]
      ptr = ptr.child[num]
    end
    ptr.count
  end

  def get_value(key)
    ptr = root
    key.chars.each do |k|
      num = to_num(k)
      return unless ptr.child[num]
      ptr = ptr.child[num]
    end
    ptr.value
  end

  def get_lcp(word)
    ptr = root
    res = []
    word.chars.each_with_index do |c, i|
      num = to_num(c)
      break unless ptr.child[num]
      res << c
      ptr = ptr.child[num]
    end
    return res.join
  end

  def all_words
    dfs(root, [])
  end

  def match_prefix_words(prefix)
    ptr = root
    prefix_chars = prefix.chars
    prefix_chars.each do |c|
      num = to_num(c)
      return [] unless ptr.child[num]
      ptr = ptr.child[num]
    end
    dfs(ptr, prefix_chars)
  end

  private
  def to_num(chr)
    chr.ord - "a".ord
  end

  def to_chr(num)
    (num + "a".ord).chr
  end

  def dfs(ptr, stack)
    words = []
    words << stack.join if ptr.is_end
    26.times do |i|
      next unless ptr.child[i]
      words.concat(dfs(ptr.child[i], stack << to_chr(i)))
      stack.pop
    end
    words
  end
end
