package ktln.lib

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import kotlin.reflect.full.memberProperties
import kotlin.reflect.jvm.isAccessible
import kotlin.test.assertFalse

/**
 * Union-Find木のテスト
 *
 */
internal class UnionFindTest {

  private lateinit var unionFind: UnionFind

  @BeforeEach
  fun setUp() {
    unionFind = UnionFind(10)
  }

  @Test
  fun isSameで親が同じものを同じと判定できる() {
    val parentsKProperty = UnionFind::class.memberProperties.first { it.name == "parents" }
    parentsKProperty.isAccessible = true
    val parents = parentsKProperty.get(unionFind) as IntArray
    parents[2] = 1
    assert(unionFind.isSame(1, 2))
  }

  @Test
  fun uniteで結合すると親が同じになる() {
    assertFalse(unionFind.isSame(1, 10))
    unionFind.unite(1, 10)
    assert(unionFind.isSame(1, 10))
  }
}
