package ktln.lib

/**
 * DSU(Union-Find木)
 *
 * @property n 木のサイズ
 */
class DSU(private val n: Int) {

  // 負の整数の場合、絶対値が連結成分数を表す
  private val parentOrSize = IntArray(n) { -1 }
  var groupSize: Int = n
    private set

  /**
   * 親を取得
   * @param u 要素番号
   * @return 親番号
   */
  val root = DeepRecursiveFunction<Int, Int> { u ->
    if (parentOrSize[u] < 0) {
      u
    } else {
      parentOrSize[u] = callRecursive(parentOrSize[u])
      parentOrSize[u]
    }
  }
  val leader = root

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
    parentOrSize[ru] += parentOrSize[rv]
    parentOrSize[rv] = ru
    groupSize--
  }

  val merge = ::unite

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
  fun size(u: Int) = -parentOrSize[root(u)]

  /**
   * グループ
   *
   * @return Map<ルート, グループメンバ>
   */
  fun groupList(): List<List<Int>> {
    val groups = mutableMapOf<Int, MutableList<Int>>()
    (0 until n).forEach { groups.getOrPut(root(it)) { mutableListOf() }.add(it) }
    return groups.values.toList()
  }

  /**
   * ルートリスト
   *
   * @return ルートリスト
   */
  fun rootList(): List<Int> = (0 until n).filter { parentOrSize[it] < 0 }
}
