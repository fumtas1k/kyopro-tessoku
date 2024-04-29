package ktln.lib

/**
 * DSU(Union-Find木)
 *
 * @property size 木のサイズ
 */
class DSU(private val size: Int) {

  // 負の整数の場合、絶対値が連結成分数を表す
  private val parentsOrSize = IntArray(size) { -1 }

  /**
   * 親を取得
   * @param u 要素番号
   * @return 親番号
   */
  val root = DeepRecursiveFunction<Int, Int> { u ->
    if (parentsOrSize[u] < 0) {
      u
    } else {
      parentsOrSize[u] = callRecursive(parentsOrSize[u])
      parentsOrSize[u]
    }
  }

  /**
   * 結合
   * @param u 要素番号
   * @param v 結合する要素番号
   */
  fun unite(u: Int, v: Int) {
    var ru = root(u)
    var rv = root(v)
    if (ru == rv) return
    if (size(ru) < size(rv)) {
      val temp = ru
      ru = rv
      rv = temp
    }
    parentsOrSize[ru] += parentsOrSize[rv]
    parentsOrSize[rv] = ru
  }

  /**
   * 親が同じか
   * @param u 要素番号
   * @param v 比較する要素番号
   * @return true or false
   */
  fun isSame(u: Int, v: Int): Boolean = root(u) == root(v)

  /**
   * 連結成分数
   *
   * @param u 要素番号
   * @return 連結成分数
   */
  fun size(u: Int) = -parentsOrSize[root(u)]

  /**
   * グループ
   *
   * @return Map<ルート, グループメンバ>
   */
  fun groups(): Map<Int, List<Int>> = parentsOrSize.mapIndexed { i, _ -> root(i) to i }
    .groupBy { it.first }
    .mapValues { (_, list) -> list.map { it.second } }

  /**
   * ルートリスト
   *
   * @return ルートリスト
   */
  fun rootList(): List<Int> = (0..size - 1).filter { parentsOrSize[it] < 0 }
}
