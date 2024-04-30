package ktln.lib

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.CsvSource
import org.junit.jupiter.params.provider.ValueSource
import kotlin.reflect.full.memberProperties
import kotlin.reflect.jvm.isAccessible

/**
 * DSU(Union-Find木)のテスト
 *
 */
class DSUTest {

  private lateinit var dsu: DSU

  @BeforeEach
  fun setUp() {
    dsu = DSU(10)
  }

  @ParameterizedTest
  @ValueSource(
    ints =
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  )
  fun rootの初期値は自分自身であること(u: Int) {
    assertEquals(u, dsu.root(u))
  }

  @Test
  fun isSameで親が同じものを同じと判定できる() {
    val parentOrSizeKProperty = DSU::class.memberProperties.first { it.name == "parentOrSize" }
    parentOrSizeKProperty.isAccessible = true
    val parentOrSize = parentOrSizeKProperty.get(dsu) as IntArray
    parentOrSize[2] = 1
    parentOrSize[1] = -2
    assertTrue(dsu.isSame(1, 2))
  }

  @Test
  fun uniteで結合すると親が同じになる() {
    assertFalse(dsu.isSame(0, 8))
    dsu.unite(0, 8)
    assertTrue(dsu.isSame(0, 8))
  }

  @Nested
  inner class sizeのテスト {
    @BeforeEach
    fun setUp() {
      listOf(0 to 1, 1 to 2, 3 to 0, 4 to 5, 5 to 6, 7 to 8).forEach {
        dsu.unite(it.first, it.second)
      }
    }

    @ParameterizedTest
    @CsvSource(
      value = [
        "0,4",
        "1,4",
        "2,4",
        "3,4",
        "4,3",
        "5,3",
        "6,3",
        "7,2",
        "8,2",
        "9,1"
      ]
    )
    fun sizeの結果が正しいこと(u: Int, expected: Int) {
      assertEquals(expected, dsu.size(u))
    }
  }

  @Nested
  inner class groupsとrootListのテスト {
    @BeforeEach
    fun setUp() {
      listOf(0 to 1, 1 to 2, 3 to 0, 4 to 5, 5 to 6, 7 to 8).forEach {
        dsu.unite(it.first, it.second)
      }
    }

    @Test
    fun groupsが正しいこと() {
      val expected = mapOf(
        0 to listOf(0, 1, 2, 3),
        4 to listOf(4, 5, 6),
        7 to listOf(7, 8),
        9 to listOf(9)
      )
      assertEquals(expected, dsu.groups())
    }

    @Test
    fun rootListが正しいこと() {
      val expected = listOf(0, 4, 7, 9)
      assertEquals(expected, dsu.rootList())
    }
  }
}
