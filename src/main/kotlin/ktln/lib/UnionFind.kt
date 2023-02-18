package ktln.lib

/**
 * Union-Find木
 *
 * @property size 木のサイズ
 */
class UnionFind(private val size: Int) {

  private val parents = MutableList(size + 1) { it }

  /**
   * 結合
   * @param u 要素番号
   * @param v 結合する要素番号
   */
  fun unite(u: Int, v: Int) {
    val ru = root(u)
    val rv = root(v)
    if (ru == rv) return
    parents[rv] = ru
  }

  /**
   * 親が同じか
   * @param u 要素番号
   * @param v 比較する要素番号
   * @return true or false
   */
  fun isSame(u: Int, v: Int): Boolean = root(u) == root(v)

  /**
   * 親を取得
   * @param u 要素番号
   * @return 親番号
   */
  private fun root(u: Int): Int {
    if (u == parents[u]) return u
    parents[u] = root(parents[u])
    return parents[u]
  }
}
