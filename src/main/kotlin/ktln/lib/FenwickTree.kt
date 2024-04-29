package ktln.lib

/**
 * FenwickTree
 *
 * @property size サイズ
 */
class FenwickTree(val size: Int) {
  private val data: LongArray = LongArray(size + 1) { 0L }

  constructor(data: List<Long>) : this(data.size) {
    data.forEachIndexed { i, d ->
      val idx = i + 1
      this.data[idx] += d
      val up = idx + (idx).and(-idx)
      if (up > size) return@forEachIndexed
      this.data[up] += this.data[idx]
    }
  }

  /**
   * 加算
   *
   * @param pos 位置
   * @param value 値
   */
  fun add(pos: Int, value: Long) {
    var idx = pos + 1
    while (idx <= size) {
      data[idx] += value
      idx += idx.and(-idx)
    }
  }

  fun addByRange(l: Int, r: Int, value: Long) {
    add(l, value)
    add(r, -value)
    if (l > r) {
      add(0, value)
      add(size - 1, -value)
    }
  }

  /**
   * 合計
   *
   * [l, r) の合計
   * r = null: [0, l) の合計
   * @param l 左
   * @param r 右
   * @return 合計
   */
  fun sum(l: Int, r: Int? = null): Long = if (r == null) _sum(l) else _sum(r) - _sum(l)

  private fun _sum(r: Int): Long {
    var idx = r
    var res = 0L
    while (idx > 0) {
      res += data[idx]
      idx -= idx.and(-idx)
    }
    return res
  }
}