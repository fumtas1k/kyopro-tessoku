const SegmentTree = require('../lib/segment_tree');

describe('SegmentTree', () => {
  describe('加算', () => {
    const arr = [3, 7, 5, 2, 1, 4, 10, 8, 9, 6];
    let segment_tree;

    beforeEach(() => {
      segment_tree = new SegmentTree(arr, 0, (a, b) => a + b);
    });

    describe('要素数が10個の配列の場合', () => {
      test('葉の数は16', () => {
        expect(segment_tree.leaf_size).toBe(16);
      });
    });

    describe('prodで範囲を指定した場合', () => {
      test('その範囲の合計が得られる', () => {
        expect(segment_tree.prod(0, 5)).toBe(arr.slice(0, 5).reduce((a, b) => a + b, 0));
      });
    });

    describe('要素の値を更新した場合', () => {
      beforeEach(() => {
        segment_tree.set(1, 0);
      });

      test('prodで更新後の合計が得られる', () => {
        expect(segment_tree.prod(0, 5)).toBe(arr.slice(0, 5).reduce((a, b) => a + b, 0) - 7);
      });
    });
  });

  describe('最大値', () => {
    const arr = [3, 7, 5, 2, 1, 4, 10, 8, 9, 6];
    let segment_tree;

    beforeEach(() => {
      segment_tree = new SegmentTree(arr, -Infinity, Math.max);
    });

    describe('prodで範囲を指定した場合', () => {
      test('その範囲の最大値が得られる', () => {
        expect(segment_tree.prod(0, 5)).toBe(7);
      });
    });

    describe('要素の値を更新した場合', () => {
      beforeEach(() => {
        segment_tree.set(1, 1_000_000);
      });

      test('prodで指定した範囲の更新後の最大値が得られる', () => {
        expect(segment_tree.prod(0, 5)).toBe(1_000_000);
      });
    });
  });
});
