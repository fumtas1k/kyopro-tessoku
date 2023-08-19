package ktln.lib

import org.junit.jupiter.api.Assertions.assertIterableEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import kotlin.reflect.full.memberProperties
import kotlin.reflect.jvm.isAccessible
import kotlin.test.assertEquals

/**
 * 最大流量のテスト
 *
 */
class MaxFlowTest {

  private lateinit var maxFlow: MaxFlow

  @Test
  fun addEdgeで流量が追加できる() {
    maxFlow = MaxFlow(2)
    maxFlow.addEdge(1, 2, 5)
    val expected = arrayOf(
      mutableListOf<MaxFlow.Edge>(),
      mutableListOf(MaxFlow.Edge(2, 0, 5)),
      mutableListOf(MaxFlow.Edge(1, 0, 0))
      )
    val property = MaxFlow::class.memberProperties.first { it.name == "graph" }
    property.isAccessible = true
    val actual = property.get(maxFlow) as Array<MutableList<MaxFlow.Edge>>
    assertIterableEquals(expected, actual)
  }

  @Nested
  inner class calculateMaxFlow {
    @BeforeEach
    fun setUp() {
      maxFlow = MaxFlow(3)
    }

    @Test
    fun 最大流量が得られる() {
      maxFlow.addEdge(1, 2, 5)
      maxFlow.addEdge(2, 3, 2)
      val expected = 2L
      val actual = maxFlow.calculateMaxFlow(1, 3)
      assertEquals(expected, actual)
    }

    @Test
    fun 一部の流量が0の場合最大流量は0() {
      maxFlow.addEdge(1, 2, 5)
      maxFlow.addEdge(2, 3, 0)
      val expected = 0L
      val actual = maxFlow.calculateMaxFlow(1, 3)
      assertEquals(expected, actual)
    }
  }
}
