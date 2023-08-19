/**
 * A68
 * Ford-Fulkerson法
 * Maximum Flow
 * 実行時間: 1s以内
 */

package ktln

import java.io.File
import kotlin.math.min

class MaxFlow(private val size: Int) {

  /**
   * 辺
   *
   * @property to 頂点
   * @property toIdx 頂点のindex
   * @property cap キャパシティ
   */
  data class Edge(val to: Int, val toIdx: Int, var cap: Long)

  private val used = BooleanArray(size + 1) { false }
  private val graph = List(size + 1) { mutableListOf<Edge>() }

  /**
   * 辺追加
   *
   * @param from 頂点
   * @param to 頂点
   * @param cap キャパシティ
   */
  fun addEdge(from: Int, to: Int, cap: Long) {
    val fromIdx = graph[from].size
    val toIdx = graph[to].size
    graph[from].add(Edge(to, toIdx, cap))
    graph[to].add(Edge(from, fromIdx, 0L))
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
      used.fill(false)
      val flow = dfs(u, v, Long.MAX_VALUE)
      if (flow == 0L) break
      totalFlow += flow
    }
    return totalFlow
  }

  private fun dfs(pos: Int, goal: Int, minFlow: Long): Long {
    if (pos == goal) return minFlow
    used[pos] = true
    graph[pos].forEach { edge ->
      if (edge.cap == 0L || used[edge.to]) return@forEach
      val flow = dfs(edge.to, goal, minOf(minFlow, edge.cap))
      if (flow == 0L) return@forEach
      edge.cap -= flow
      graph[edge.to][edge.toIdx].cap += flow
      return flow
    }
    return 0L
  }
}

fun main() {
  val (N, M) = readLine()!!.split(" ").map(String::toInt)
  val maxFlow = MaxFlow(N)
  repeat(M) {
    val (a, b, c) = readLine()!!.split(" ").let { Triple(it[0].toInt(), it[1].toInt(), it[2].toLong()) }
    maxFlow.addEdge(a, b, c)
  }
  println(maxFlow.calculateMaxFlow(1, N))
}
