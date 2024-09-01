package ktln.lib

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import kotlin.math.max

/**
 * セグメント木のテスト
 *
 */
internal class SegmentTreeWTest {
  private lateinit var segmentTreeW: SegmentTreeW<Long>
  private val arr = listOf(3L, 7L, 5L, 2L, 1L, 4L, 8L, 10L, 9L, 6L)

  @Nested
  inner class 加算 {
    @BeforeEach
    fun setUp() {
      segmentTreeW = SegmentTreeW(arr, 0L) { a, b -> a + b }
    }

    @Test
    fun 葉の数が16であること() {
      assertEquals(16, segmentTreeW.leafSize)
    }

    @Test
    fun queryで範囲を指定した場合その範囲の合計が得られる() {
      val expected = arr.subList(0, 7).sum()
      val actual = segmentTreeW.query(0, 7)
      assertEquals(expected, actual)
    }

    @Test
    fun setで値を更新するとそれを含む範囲の合計も更新される() {
      segmentTreeW.set(1, 0L)
      val expected = arr.subList(0, 5).sum() - 7
      val actual = segmentTreeW.query(0, 5)
      assertEquals(expected, actual)
    }
  }

  @Nested
  inner class 最大値 {
    @BeforeEach
    fun setUp() {
      segmentTreeW = SegmentTreeW(arr, Long.MIN_VALUE, ::max)
    }

    @Test
    fun queryで範囲を指定した場合その範囲の最大値が得られる() {
      val expected = arr.subList(0, 7).max()
      val actual = segmentTreeW.query(0, 7)
      assertEquals(expected, actual)
    }

    @Test
    fun setで値を更新するとそれを含む範囲の合計も更新される() {
      segmentTreeW.set(2, 1_000_000L)
      val expected = 1_000_000L
      val actual = segmentTreeW.query(0, 5)
      assertEquals(expected, actual)
    }
  }
}