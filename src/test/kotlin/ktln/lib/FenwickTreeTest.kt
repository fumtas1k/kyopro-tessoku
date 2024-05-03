package ktln.lib

import org.junit.jupiter.api.Assertions.assertArrayEquals
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.CsvSource
import kotlin.reflect.full.memberProperties
import kotlin.reflect.jvm.isAccessible

class FenwickTreeTest {

  private lateinit var fenwickTree: FenwickTree

  @Nested
  inner class コンストラクタ {

    @Test
    fun 引数がIntの場合() {
      fenwickTree = FenwickTree(3)
      val dataKProperty = FenwickTree::class.memberProperties.first { it.name == "data" }
      dataKProperty.isAccessible = true
      val data = dataKProperty.get(fenwickTree) as LongArray
      assertArrayEquals(longArrayOf(0L, 0L, 0L, 0L), data)
    }

    @Test
    fun 引数がリストの場合() {
      fenwickTree = FenwickTree(listOf(1L, 2L, 3L, 4L))
      val dataKProperty = FenwickTree::class.memberProperties.first { it.name == "data" }
      dataKProperty.isAccessible = true
      val data = dataKProperty.get(fenwickTree) as LongArray
      assertArrayEquals(longArrayOf(0L, 1L, 3L, 3L, 10L), data)
    }
  }

  @Nested
  inner class add_and_addByRangeメソッド {
    @BeforeEach
    fun setUp() {
      fenwickTree = FenwickTree(5)
    }

    @Test
    fun add() {
      fenwickTree.add(0, 1)
      val dataKProperty = FenwickTree::class.memberProperties.first { it.name == "data" }
      dataKProperty.isAccessible = true
      val data = dataKProperty.get(fenwickTree) as LongArray
      assertArrayEquals(longArrayOf(0L, 1L, 1L, 0L, 1L, 0L), data)
    }

    @Test
    fun addByRange() {
      fenwickTree.add(0, 1L)
      fenwickTree.addByRange(2, 4, 2L)
      val dataKProperty = FenwickTree::class.memberProperties.first { it.name == "data" }
      dataKProperty.isAccessible = true
      val data = dataKProperty.get(fenwickTree) as LongArray
      assertArrayEquals(longArrayOf(0L, 1L, 1L, 2L, 3L, -2L), data)
    }
  }

  @Nested
  inner class sumメソッド {
    @BeforeEach
    fun setUp() {
      fenwickTree = FenwickTree(listOf(1L, 2L, 3L, 4L, 5L))
    }

    @ParameterizedTest
    @CsvSource(
      value = [
        "1,1",
        "2,3",
        "3,6",
        "4,10",
        "5,15"
      ]
    )
    fun sum_only_l(l: Int, expected: Long) {
      assertEquals(expected, fenwickTree.sum(l))
    }

    @ParameterizedTest
    @CsvSource(
      value = [
        "0,5,15",
        "1,5,14",
        "2,5,12",
        "2,3,3"
      ]
    )
    fun sum(l: Int, r: Int, expected: Long) {
      assertEquals(expected, fenwickTree.sum(l, r))
    }
  }
}