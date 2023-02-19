package ktln.lib

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import java.io.File
import kotlin.test.assertEquals

/**
 * 最大流量のテスト
 *
 */
class MaxFlowTest {

  private lateinit var maxFlow: MaxFlow

  @BeforeEach
  fun setUp() {
    File("question/A68.txt").readLines().forEachIndexed {idx, line ->
      if (idx == 0) {
        val (n, _) = line.split(" ").map(String::toInt)
        maxFlow = MaxFlow(n)
      } else {
        val (a, b, c) = line.split(" ").let { Triple(it[0].toInt(), it[1].toInt(), it[2].toLong()) }
        maxFlow.addEdge(a, b, c)
      }
    }
  }

  @Test
  fun 例題のテスト() {
    val expected = File("answer/A68.txt").readLines()[0].toLong()
    val actual = maxFlow.calculateMaxFlow(1, maxFlow.size)
    assertEquals(expected, actual)
  }
}