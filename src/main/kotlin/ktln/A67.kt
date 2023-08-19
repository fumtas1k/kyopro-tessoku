/**
 * A67
 * 最小全域木
 * クラスカル法(貪欲法 + Union-Find木)
 * 実行時間: 1s以内
 */

package ktln

class UnionFind(private val size: Int) {
  private val parents: IntArray
  init {
    parents = IntArray(size + 1) { it }
  }

  fun root(u: Int): Int {
    if (u == parents[u]) return u
    parents[u] = root(parents[u])
    return parents[u]
  }

  fun unite(u: Int, v: Int) {
    val ru = root(u)
    val rv = root(v)
    if (ru == rv) return
    parents[rv] = ru
  }

  fun isSame(u: Int, v: Int): Boolean = root(u) == root(v)
}

fun main() {
  val (N, M) = readLine()!!.split(" ").map(String::toInt)
  val ABC = Array(M) { readLine()!!.split(" ").map(String::toInt) }.sortedBy { it.last() }

  var ans = 0
  val uf = UnionFind(N + 1)
  ABC.forEach { (a, b, c) ->
    if (uf.isSame(a, b)) return@forEach
    uf.unite(a, b)
    ans += c
  }

  println(ans)
}
