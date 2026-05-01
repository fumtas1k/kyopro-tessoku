# ダブリング（バイナリリフティング）による木の最小共通祖先 (LCA: Lowest Common Ancestor)
#
# @example
#   lca = LCA.new(7, 0)
#   lca.add_edge(0, 1)
#   lca.add_edge(0, 2)
#   lca.add_edge(1, 3)
#   lca.add_edge(1, 4)
#   lca.add_edge(2, 5)
#   lca.add_edge(2, 6)
#   lca.build
#   lca.get(3, 4) #=> 1
#   lca.get(3, 6) #=> 0
#   lca.get(5, 5) #=> 5
#
# @note 入力は連結な木であることを前提とする。{#build} 前に {#get} を呼ぶと例外。
# @note 計算量: 前処理 O(N log N) / クエリ O(log N) / 空間 O(N log N)
class LCA
  # @return [Array<Array<Integer>>] +parents[k][v]+ で頂点 v の 2^k 個上の祖先
  # @return [Array<Integer>] 各頂点の根からの深さ
  # @return [Array<Integer>] 各頂点の DFS 行きがけ順 (preorder, 0-origin)
  # @return [Array<Array<Integer>>] 隣接リスト
  # @return [Integer] ダブリングの段数 (= +n.bit_length+)
  # @return [Integer] 頂点数
  # @return [Integer] 根の頂点番号
  attr_reader :parents, :depth, :orders, :edges, :bit, :size, :root

  # @param n [Integer] 頂点数
  # @param root [Integer] 根とする頂点番号 (0-origin)
  def initialize(n, root)
    @size = n
    @root = root
    @bit = n.bit_length
    @parents = Array.new(bit) { [0] * n }
    @depth = [0] * n
    @orders = Array.new(n)
    @edges = Array.new(n) { [] }
    @built = false
  end

  # 無向辺を追加する
  # @param u [Integer] 端点の頂点番号
  # @param v [Integer] 端点の頂点番号
  # @return [void]
  # @note 呼び出すと {#built?} は false に戻り、再度 {#build} が必要となる
  def add_edge(u, v)
    @built = false
    edges[u] << v
    edges[v] << u
  end

  # ダブリングテーブルを構築する。{#get} を呼ぶ前に必ず実行すること
  # @return [void]
  # @note 計算量: O(N log N)
  def build
    @built = true
    current_order = 0
    # [pos, pre]
    stack = [[root, root]]
    until stack.empty?
      pos, pre = stack.pop
      parents[0][pos] = pre
      orders[pos] = current_order
      current_order += 1
      edges[pos].each do |to|
        next if to == pre
        depth[to] = depth[pos] + 1
        stack << [to, pos]
      end
    end

    (bit - 1).times do |i|
      size.times do |j|
        parents[i + 1][j] = parents[i][parents[i][j]]
      end
    end
  end

  # 2 頂点の最小共通祖先を返す
  # @param u [Integer] 頂点番号
  # @param v [Integer] 頂点番号
  # @return [Integer] u と v の最小共通祖先の頂点番号
  # @raise [RuntimeError] {#build} 未実行の場合
  # @note 計算量: O(log N)
  def get(u, v)
    raise "buildされていません。" unless built?

    u, v = v, u if depth[u] < depth[v]
    diff = depth[u] - depth[v]
    bit.times do |i|
      next if diff[i].zero?
      u = parents[i][u]
    end
    return u if u == v

    (bit - 1).downto(0) do |i|
      next if parents[i][u] == parents[i][v]
      u = parents[i][u]
      v = parents[i][v]
    end
    parents[0][u]
  end

  private

  # @return [Boolean] {#build} 済みかどうか
  def built? = @built
end
