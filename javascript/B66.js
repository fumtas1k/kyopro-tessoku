// B66
// Union Find

// 素集合データ構造(Union-Find木)
class DSU {
  constructor(n) {
    this.n = n;
    this.groupSize = n;
    // 負の整数の場合、絶対値が連結成分数を表す
    this.parentOrSize = new Array(n).fill(-1);
  }

  root(u) {
    if (this.parentOrSize[u] < 0) return u;
    return this.parentOrSize[u] = this.root(this.parentOrSize[u]);
  }
  leader = this.root;

  unite(u, v) {
    let ru = this.root(u);
    let rv = this.root(v);
    if (ru == rv) return;
    // サイズが大きい方が小さい方を吸収する方が速度が速い
    if (this.size(ru) < this.size(rv)) [ru, rv] = [rv, ru];
    this.parentOrSize[ru] += this.parentOrSize[rv];
    this.parentOrSize[rv] = ru;
    this.groupSize--;
  }
  merge = this.unite;

  isSame(u, v) { return this.root(u) === this.root(v) };

  size(u) { return -this.parentOrSize[this.root(u)] };

  groups() {
    const groups = [];
    for (let i = 0; i < this.n; i++) {
      const root = this.root(i);
      if (!groups[root]) groups[root] = [];
      groups[root].push(i);
    }
    return Object.values(groups);
  };

  roots() { return this.parentOrSize.map((u, i) => u < 0 ? i : null).filter(u => u !== null) };
}

const input = require("fs").readFileSync("/dev/stdin", "utf8").split("\n");
const [N, M] = input[0].split(" ").map(Number);
const AB = input.slice(1, 1 + M).map(str => str.split(" ").map(Number));
const Q = input[1 + M];
const QUERY = input.slice(2 + M, 2 + M + Q).map(str => str.split(" ").map(Number));

// 運休している路線を調べる
const isSuspended = new Array(M).fill(false);
for (const query of QUERY) {
  if (query[0] === 1) isSuspended[query[1] - 1] = true;
}

const dsu = new DSU(N + 1);
// 運休しない路線はつなげておく
for (let i = 0; i < M; i++) {
  if (isSuspended[i]) continue;
  dsu.unite(...AB[i]);
}

const ans = [];
// 逆から考える
QUERY.reverse().forEach(query => {
  switch(query[0]) {
    case 1:
      dsu.unite(...AB[query[1] - 1]);
      break;
    case 2:
      ans.push(dsu.isSame(...query.slice(1, 3)) ? "Yes" : "No");
      break;
  }
});

console.log(ans.reverse().join("\n"));
