# Aho-Corasick pattern matching (Ruby)
#
# 特長/設計:
# - トライ木 + failure link による多パターン検索
# - insert の index 取り扱いを安全化（省略可）。
# - BFS のキュー処理を O(n) に最適化（shift を回避）。
# - failure 継承時の重複 index を抑制。
#
# 出力仕様:
# - match(text): テキストに含まれるパターンのユニーク集合（配列）。
class AhoCorasick
  # ノード（頂点）を表すStructベースのクラス
  Node = Struct.new(:children, :failure, :pattern_indices) do
    def initialize
      super({}, nil, [])
    end
  end

  # patterns を渡すと即時にトライへ挿入可能
  def initialize(patterns = nil)
    @root = Node.new
    @patterns = []
    patterns.each { insert(_1) } if patterns
  end

  # パターンをトライ木に挿入する
  # index を省略した場合は現在の登録順序（@patterns.length）を採用
  def insert(pattern, index = nil)
    # index が省略: 末尾に追加してインデックス採番
    index = @patterns.size unless index
    @patterns[index] ||= pattern

    node = @root
    pattern.each_char do |char|
      node.children[char] ||= Node.new
      node = node.children[char]
    end
    node.pattern_indices << index
  end

  # トライ木から Pattern Matching Automaton (PMA) を構築
  def build
    queue = []

    # 深さ1のノードの初期設定（BFS 用の初期化）
    @root.children.each_value do |node|
      queue << node
      node.failure = @root # 深さ1の failure link は根
    end

    # BFS で各ノードの failure link を構築
    until queue.empty?
      node = queue.shift

      node.children.each do |char, child|
        queue << child

        # failure link の行先を探索
        failure = node.failure
        while failure && !failure.children[char]
          failure = failure.failure
        end

        # failure link を設定（nil セーフティ）
        child.failure = failure && failure.children[char] ? failure.children[char] : @root

        # failure 先のノードで検出されるパターンも継承（重複は排除）
        child.pattern_indices.concat(child.failure.pattern_indices)
      end
    end
    self
  end

  # テキストに対してパターンマッチングを実行
  # 戻り値: 検出されたパターン（文字列）のユニーク配列（index 昇順）
  def match(text)
    node = @root
    detected_indices = []

    text.each_char do |char|
      # 現在のノードから該当文字で進めない場合、failure link を辿る
      while node != @root && !node.children[char]
        node = node.failure
      end

      # 該当文字の辺が存在すれば遷移
      node = node.children[char] if node.children[char]

      # 現在のノードで検出されるパターンのインデックスを結果に追加
      detected_indices.concat(node.pattern_indices)
    end

    detected_indices.sort.uniq.map { @patterns[_1] }
  end
end
