# トライ木

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
    word.chars.each do |c|
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
      ptr.count = ptr.child.size
      return
    end

    stack.pop
    word_chars.reverse.each do |c|
      ptr = stack.pop
      ptr.count -= ptr.child[c].size
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
    key.chars.each do |c|
      return unless ptr.child[c]
      ptr = ptr.child[c]
    end
    ptr.value
  end

  def get_lcp(word)
    ptr = root
    res = []
    word.chars.each do |c|
      break unless ptr.child[c]
      res << c
      ptr = ptr.child[c]
    end
    return res.join
  end

  def all_words
    dfs(root, []).sort
  end

  def match_prefix_words(prefix)
    ptr = root
    prefix_chars = prefix.chars
    prefix_chars.each do |c|
      return [] unless ptr.child[c]
      ptr = ptr.child[c]
    end
    dfs(ptr, prefix_chars).sort
  end

  def prefix_comb_count
    dfs2(root, [])
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
    ptr.child.each do |c, child|
      next unless child
      words.concat(dfs(child, stack << c))
      stack.pop
    end
    words
  end

  def dfs2(ptr, stack)
    cnt = 0
    cnt += (ptr.count * (ptr.count - 1)) / 2 unless ptr == root
    ptr.child.each do |c, child|
      next unless child
      cnt += dfs2(child, stack << c)
      stack.pop
    end
    cnt
  end
end
