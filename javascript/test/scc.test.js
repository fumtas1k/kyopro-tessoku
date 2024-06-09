const SCC = require("../lib/scc");

// SCCのテスト
describe('SCC', () => {
  let scc;
  let graph;
  let edges;

  beforeEach(() => {
    scc = new SCC(6);
    graph = [
      [1, 4],
      [5, 2],
      [3, 0],
      [5, 5],
      [4, 1],
      [0, 3],
      [4, 2]
    ];
    edges = [
      [3],
      [4],
      [],
      [0],
      [1, 2],
      [2, 5]
    ];
  });

  describe('addEdge', () => {
    test('辺に追加されること', () => {
      scc.addEdge(1, 4);
      expect(scc.edges).toEqual([
        [],
        [4],
        [],
        [],
        [],
        []
      ]);
    });
  });

  describe('addEdges', () => {
    test('辺に追加されること', () => {
      scc.addEdges(graph);
      expect(scc.edges).toEqual(edges);
    });
  });

  describe('scc', () => {
    beforeEach(() => {
      scc.addEdges(graph);
    });

    test('結果が正しいこと', () => {
      expect(scc.scc()).toEqual([
        [5],
        [1, 4],
        [2],
        [0, 3]
      ]);
    });
  });
});
