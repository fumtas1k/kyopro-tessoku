package ktln.lib

/**
 * セグメント木
 *
 * @property arr 対象のリスト
 * @property idElm 単位元(演算メソッドで結果がもう一方の値と同じとなる要素。足し算なら0、掛け算なら1。)
 * @property operator 演算メソッド(合計, 最大値, 最小値などの計算)
 */
class SegmentTreeR(
  private val arr: List<Long>,
  private val idElm: Long,
  private val operator: (Long, Long) -> Long
) {
  public val leafSize: Int
  private val tree: MutableList<Long>

  init {
    var i = 1
    while (i < arr.size) i *= 2
    leafSize = i
    tree = MutableList(leafSize * 2) { idElm }
    for (j in arr.indices) tree[leafSize + j] = arr[j]
    for (k in leafSize - 1 downTo 1) tree[k] = operator(tree[2 * k], tree[2 * k + 1])
  }

  /**
   * 更新
   *
   * @param pos arrのindex + 1
   * @param x 更新する値
   */
  fun update(pos: Int, x: Long) {
    var idx = pos + leafSize - 1
    tree[idx] = x
    while (idx > 1) {
      idx /= 2
      tree[idx] = operator(tree[2 * idx], tree[2 * idx + 1])
    }
  }

  /**
   * 値の取得
   *
   * @param l 求めたい半開区間の左
   * @param r 求めたい半開区間の右（その値は含まない）
   * @param a 現在の半開区間の左
   * @param b 現在の半開区間の右（その値は含まない）
   * @param idx 現在のtreeのインデックス
   * @return
   */
  fun query(l: Int, r: Int, a: Int = 1, b: Int = leafSize + 1, idx: Int = 1): Long  {
    if (r <= a || b <= l) return idElm
    if (l <= a && b <= r) return tree[idx]
    val mid = (a + b) / 2
    return operator(query(l, r, a, mid, idx * 2), query(l, r, mid, b, idx * 2 + 1))
  }
}