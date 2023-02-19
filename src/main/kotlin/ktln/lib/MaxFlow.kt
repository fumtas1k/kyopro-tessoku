package ktln.lib

import kotlin.math.min

/**
 * 最大流量
 *
 * @property size 頂点の数
 */
class MaxFlow(val size: Int) {

  /**
   * 辺
   *
   * @property to 頂点
   * @property toIdx 頂点のindex
   * @property cap キャパシティ
   */
  data class Edge(val to: Int, val toIdx: Int, var cap: Long)

  private val used = MutableList(size + 1) { false }
  private val graph = MutableList(size + 1) { mutableListOf<Edge>() }

  /**
   * 辺追加
   *
   * @param from 頂点
   * @param to 頂点
   * @param cap キャパシティ
   */
  fun addEdge(from: Int, to: Int, cap: Long) {
    val graphFromSize = graph[from].size
    val graphToSize = graph[to].size
    graph[from].add(Edge(to, graphToSize, cap))
    graph[to].add(Edge(from, graphFromSize, 0L))
  }

  /**
   * 最大流量計算
   *
   * @param u 頂点
   * @param v 頂点
   * @return 最大流量
   */
  fun calculateMaxFlow(u: Int, v: Int): Long {
    var totalFlow = 0L
    while (true) {
      repeat(size + 1) { used[it] = false }
      val flow = dfs(u, v, Long.MAX_VALUE)
      if (flow == 0L) break
      totalFlow += flow
    }
    return totalFlow
  }

  private fun dfs(pos: Int, goal: Int, minFlow: Long): Long {
    if (pos == goal) return minFlow
    used[pos] = true
    for (edge in graph[pos]) {
      if (edge.cap == 0L || used[edge.to]) continue
      val flow = dfs(edge.to, goal, min(minFlow, edge.cap))
      if (flow == 0L) continue
      edge.cap -= flow
      graph[edge.to][edge.toIdx].cap += flow
      return flow
    }
    return 0L
  }
}