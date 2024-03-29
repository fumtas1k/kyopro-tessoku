package ktln.lib

/**
 * セグメント木
 *
 * @property list 対象のリスト
 * @property idElm 単位元(演算メソッドで結果がもう一方の値と同じとなる要素。足し算なら0、掛け算なら1。)
 * @property operator 演算メソッド(合計, 最大値, 最小値などの計算)
 */
class SegmentTreeW(
  private val list: List<Long>,
  private val idElm: Long,
  private val operator: (Long, Long) -> Long
) {
  public val leafSize: Int
  private val tree: LongArray
  init {
    var size = 1
    while (size < list.size) size *= 2
    leafSize = size
    tree = LongArray(leafSize * 2) { idElm }
    repeat(list.size) { tree[leafSize + it] = list[it] }
    (leafSize - 1 downTo 1).forEach { tree[it] = operator(tree[2 * it], tree[2 * it + 1]) }
  }

  /**
   * 更新
   *
   * @param pos listのindex + 1
   * @param x 更新する値
   */
  fun update(pos: Int, x: Long) {
    var idx = pos + leafSize - 1
    tree[idx] = x
    while (idx > 1) {
      idx /= 2
      tree[idx] = operator(tree[idx * 2], tree[2 * idx + 1])
    }
  }

  /**
   * 値の取得
   *
   * @param l 求めたい半開区間の左
   * @param r 求めたい半開区間の右（その値は含まない）
   * @return
   */
  fun query(l: Int, r: Int): Long  {
    if (l < 1 || l >= r || r > leafSize + 1) return idElm
    var left = l + leafSize - 1
    var right = r + leafSize - 2
    var leftAns = idElm
    var rightAns = idElm
    while (left <= right) {
      if (left % 2 == 1) leftAns = operator(leftAns, tree[left++])
      if (right % 2 == 0) rightAns = operator(rightAns, tree[right--])
      left /= 2
      right /= 2
    }
    return operator(leftAns, rightAns)
  }
}
