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

fun main() {
  val lines = File("question/A68.txt").readLines()
  val (n, m) = lines[0].split(" ").map(String::toInt)
  val maxFlow = MaxFlow(n)
  lines.subList(1, m + 1).forEach { line ->
    val (a, b, c) = line.split(" ").let { Triple(it[0].toInt(), it[1].toInt(), it[2].toLong()) }
    maxFlow.addEdge(a, b, c)
  }
  val expected = File("answer/A68.txt").readLines()[0].toLong()
  val actual = maxFlow.calculateMaxFlow(1, n)
  println(expected == actual)
}