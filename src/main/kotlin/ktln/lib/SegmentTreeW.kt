package ktln.lib

/**
 * セグメント木
 *
 * @property list 対象のリスト
 * @property idElm 単位元(演算メソッドで結果がもう一方の値と同じとなる要素。足し算なら0、掛け算なら1。)
 * @property operator 演算メソッド(合計, 最大値, 最小値などの計算)
 */
class SegmentTreeW<T>(
  private val list: List<T>,
  private val idElm: T,
  private val operator: (T, T) -> T
) {
  val leafSize: Int
  private val tree: Array<T>

  init {
    var size = 1
    while (size < list.size) size *= 2
    leafSize = size
    tree = Array<Any?>(leafSize * 2) { idElm } as Array<T>
    repeat(list.size) { tree[leafSize + it] = list[it] }
    (leafSize - 1 downTo 1).forEach { tree[it] = operator(tree[2 * it], tree[2 * it + 1]) }
  }

  /**
   * 更新
   *
   * @param pos listのindex
   * @param x 更新する値
   */
  fun set(pos: Int, x: T) {
    var idx = pos + leafSize
    tree[idx] = x
    while (idx > 1) {
      idx /= 2
      update(idx)
    }
  }

  /**
   * 値の取得
   *
   * @param pos listのindex
   * @return 値
   */
  fun get(pos: Int): T {
    return tree[pos + leafSize]
  }

  /**
   * 値の取得
   *
   * @param l 求めたい半開区間の左
   * @param r 求めたい半開区間の右（その値は含まない）
   * @return
   */
  fun query(l: Int, r: Int): T {
    if (l < 0 || l >= r || r > leafSize + 1) return idElm
    var left = l + leafSize
    var right = r + leafSize
    var leftAns = idElm
    var rightAns = idElm
    while (left < right) {
      if (left % 2 == 1) leftAns = operator(leftAns, tree[left++])
      if (right % 2 == 1) rightAns = operator(tree[--right], rightAns)
      left /= 2
      right /= 2
    }
    return operator(leftAns, rightAns)
  }

  private fun update(index: Int) {
    tree[index] = operator(tree[index * 2], tree[2 * index + 1])
  }
}
