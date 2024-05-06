const PriorityQueue = require("../lib/priority_queue");

// 優先度付きキューのテスト
describe('PriorityQueue', () => {
  let priorityQueue;
  beforeEach(() => {
    priorityQueue = new PriorityQueue((x, y) => x[0] < y[0]);
  });

  describe('8個の要素をプッシュした場合', () => {
    beforeEach(() => {
      priorityQueue.heap = [];
      priorityQueue.push([9, 2]);
      priorityQueue.push([5, 1]);
      priorityQueue.push([3, 3]);
      priorityQueue.push([6, 5]);
      priorityQueue.push([8, 10]);
      priorityQueue.push([1, 4]);
      priorityQueue.push([4, 9]);
      priorityQueue.push([2, 6]);
    });

    it('sizeで要素数8が取得できる', () => {
      expect(priorityQueue.size()).toBe(8);
    });

    it('firstで[1, 4]が得られて要素数は変わらない', () => {
      expect(priorityQueue.first()).toEqual([1, 4]);
      expect(priorityQueue.size()).toBe(8);
    });

    it('popで[1, 4]が取得でき要素数が7になる', () => {
      expect(priorityQueue.pop()).toEqual([1, 4]);
      expect(priorityQueue.size()).toBe(7);
    });

    it('popで得られる値が正しいこと', () => {
      [
        [1, 4],
        [2, 6],
        [3, 3],
        [4, 9],
        [5, 1],
        [6, 5],
        [8, 10],
        [9, 2],
      ].forEach(expected => {
        expect(priorityQueue.pop()).toEqual(expected);
      });
    });
  });

  describe('まとめてプッシュした場合', () => {
    beforeEach(() => {
      priorityQueue.pushAll([
        [9, 2],
        [5, 1],
        [3, 3],
        [6, 5],
        [8, 10],
        [1, 4],
        [4, 9],
        [2, 6],
      ]);
    });

    it('popで得られる値が正しいこと', () => {
      [
        [1, 4],
        [2, 6],
        [3, 3],
        [4, 9],
        [5, 1],
        [6, 5],
        [8, 10],
        [9, 2],
      ].forEach(expected => {
        expect(priorityQueue.pop()).toEqual(expected);
      });
    });
  });

  describe('配列で新規作成した場合', () => {
    it('popで得られる値が正しいこと', () => {
      const actual = new PriorityQueue((x, y) => x[0] < y[0],
      [
        [9, 2],
        [5, 1],
        [3, 3],
        [6, 5],
        [8, 10],
        [1, 4],
        [4, 9],
        [2, 6],
      ]);

      [
        [1, 4],
        [2, 6],
        [3, 3],
        [4, 9],
        [5, 1],
        [6, 5],
        [8, 10],
        [9, 2],
      ].forEach(expected => {
        expect(actual.pop()).toEqual(expected);
      });
    });
  });

  describe('すべてを取り出した場合', () => {
    beforeEach(() => {
      priorityQueue.push([9, 2]);
      priorityQueue.push([5, 1]);
      priorityQueue.pop();
      priorityQueue.pop();
    });
    it('heapは空', () => {
      expect(priorityQueue.isEmpty()).toBeTruthy();
    });
  });
});
