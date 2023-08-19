/**
 * A58
 * セグメント木(RMQ)
 * 実行時間: 3s以内
 */

class SegmentTreeW(
  private val list: List<Long>,
  private val idElm: Long,
  private val operator: (Long, Long) -> Long
) {
  private val leafSize: Int
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
    var idx = leafSize + pos - 1
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

fun main() {
  val (N, Q) = readLine()!!.split(" ").map(String::toInt)
  val QUERY = Array(Q) { readLine()!!.split(" ").map(String::toInt) }
  val segmentTree = SegmentTreeW(List(N) { 0L }, 0L) { a, b -> maxOf(a, b) }
  QUERY.forEach {
    when (it[0]) {
      1 -> segmentTree.update(it[1], it[2].toLong())
      2 -> println(segmentTree.query(it[1], it[2]))
    }
  }
}
