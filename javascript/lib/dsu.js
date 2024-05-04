// 素集合データ構造(Union-Find木)

class DSU {
  constructor(n) {
    this.n = n;
    // 負の整数の場合、絶対値が連結成分数を表す
    this.parentOrSize = new Array(n).fill(-1);
  }

  root(u) {
    if (this.parentOrSize[u] < 0) return u;
    return this.parentOrSize[u] = this.root(this.parentOrSize[u]);
  }

  unite(u, v) {
    let ru = this.root(u);
    let rv = this.root(v);
    if (ru == rv) return;
    // サイズが大きい方が小さい方を吸収する方が速度が速い
    if (this.size(ru) < this.size(rv)) [ru, rv] = [rv, ru];
    this.parentOrSize[ru] += this.parentOrSize[rv];
    this.parentOrSize[rv] = ru;
  }

  isSame(u, v) { return this.root(u) === this.root(v) };

  size(u) { return -this.parentOrSize[this.root(u)] };

  groups() {
    const map = new Map();
    for (let i = 0; i < this.n; i++) {
      const ri = this.root(i);
      if (!map.has(ri)) map.set(ri, []);
      map.get(ri).push(i);
    }
    return map;
  };

  roots() { return this.parentOrSize.map((u, i) => u < 0 ? i : null).filter(u => u !== null) };
}

module.exports = DSU;
