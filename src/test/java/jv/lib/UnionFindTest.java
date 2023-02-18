package jv.lib;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Union-Find木のテスト
 *
 */
class UnionFindTest {

  private UnionFind unionFind;

  @BeforeEach
  public void setUp() {
    unionFind = new UnionFind(10);
  }

  @Test
  public void isSameで親が同じものを同じと判定できる() throws NoSuchFieldException, IllegalAccessException {
    var parentsField = UnionFind.class.getDeclaredField("parents");
    parentsField.setAccessible(true);
    var parents = (int[]) parentsField.get(unionFind);
    parents[2] = 1;
    assertTrue(unionFind.isSame(1, 2));
  }

  @Test
  public void uniteで結合すると親が同じになる() {
    assertFalse(unionFind.isSame(1, 10));
    unionFind.unite(1, 10);
    assertTrue(unionFind.isSame(1, 10));
  }
}