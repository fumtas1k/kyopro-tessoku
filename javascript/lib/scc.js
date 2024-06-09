// 強連結成分(Strongly Connected Components)
// 無向グラフでは使用できない

class SCC {
  constructor(size) {
    this.size = size;
    this.edges = [...Array(this.size)].map(() => []);
  }

  addEdge(from, to) {
    this.edges[from].push(to);
  }

  addEdges(edges) {
    edges.forEach((edge) => this.addEdge(...edge));
  }

  scc() {
    const [groupSize, ids] = this.#sccIds();
    const groups = [...Array(groupSize)].map(() => []);
    ids.forEach((id, i) => groups[id].push(i));
    return groups;
  }

  #sccIds() {
    let groupNum = 0;
    let currentOrd = 0;
    const visited = [];
    const ord = [];
    const low = [];
    const ids = [];

    const dfs = from => {
      if (ord[from]) return;
      ord[from] = currentOrd;
      low[from] = currentOrd++;
      visited.push(from);

      this.edges[from].forEach(to => {
        if (ord[to]) {
          low[from] = Math.min(low[from], ord[to]);
        } else {
          dfs(to);
          low[from] = Math.min(low[from], low[to]);
        }
      });

      if (ord[from] !== low[from]) return;
      while (visited.length !== 0) {
        const to = visited.pop();
        ord[to] = this.size;
        ids[to] = groupNum;
        if (from == to) break;
      }
      groupNum++;
    }

    for (let i = 0; i < this.size; i++) dfs(i);

    return [groupNum, ids.map(i => groupNum - 1 - i)];
  }
}

module.exports = SCC;
