package lib

/**
 * Union-Find木
 *
 * @property size 木のサイズ
 */
class UnionFind(private val size: Int) {

  private val parents = MutableList(size + 1) { it }

  /**
   * 結合
   * @property u 要素番号
   * @property v 比較する要素番号
   */
  fun unite(u: Int, v: Int) {
    val ru = root(u)
    val rv = root(v)
    if (ru == rv) return
    parents[rv] = ru
  }

  /**
   * 親が同じか
   * @property u 要素番号
   * @property v 比較する要素番号
   * @return true or false
   */
  fun isSame(u: Int, v: Int): Boolean = root(u) == root(v)

  private fun root(u: Int): Int {
    if (u == parents[u]) return u
    parents[u] = root(parents[u])
    return parents[u]
  }
}
