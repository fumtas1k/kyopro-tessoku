package jv.lib;

/**
 * Union-Find木
 */
class UnionFind {

  private int[] parents;

  public UnionFind(int size) {
    parents = new int[size + 1];
    for (int i = 0; i <= size; i++) {
      parents[i] = i;
    }
  }

  /**
   * 結合
   * @param u 要素番号
   * @param v 結合する要素番号
   */
  public void unite(int u, int v) {
    var ru = root(u);
    var rv = root(v);
    if (ru == rv) {
      return;
    }
    parents[rv] = ru;
  }

  /**
   * 親が同じか
   * @param u 要素番号
   * @param v 比較する要素番号
   * @return true or false
   */
  public boolean isSame(int u, int v) {
    return root(u) == root(v);
  }

  /**
   * 親を取得
   * @param u 要素番号
   * @return 親番号
   */
  private int root(int u) {
    if (u == parents[u]) {
      return u;
    }
    parents[u] = root(parents[u]);
    return parents[u];
  }
}
