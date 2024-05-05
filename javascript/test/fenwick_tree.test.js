const { beforeEach } = require("node:test");
const FenwickTree = require("../lib/fenwick_tree");

/**
 * FenwickTreeのテスト
 */
describe("FenwickTree", () => {
  const init = [...Array(10)].map((_, i) => i);
  const initResult = [0, 0, 1, 2, 6, 4, 9, 6, 28, 8, 17];
  let ft;

  describe("初期化テスト", () => {
    describe("数値で初期化する場合", () => {
      it("データが正しいこと", () => {
        ft = new FenwickTree(10);
        expect(ft.data).toEqual(new Array(11).fill(0));
      });
    });

    describe("配列で初期化した場合", () => {
      it("データが正しいこと", () => {
        ft = new FenwickTree(init);
        expect(ft.data).toEqual(initResult);
      });
    });
  });

  describe("加算のテスト", () => {
    describe("数値で初期化後加算した場合", () => {
      it("データが正しいこと", () => {
        ft = new FenwickTree(10);
        init.forEach(i => ft.add(i, i));
        expect(ft.data).toEqual(initResult);
      });
    });
  });

  describe("合計のテスト", () => {
    beforeAll(() => {
      ft = new FenwickTree(init);
    });
    it.each([
      {l: 10, res: 45},
      {l: 5, res: 10},
      {l: 5, r: 10, res: 35}
    ])("合計が正しいこと", ({ l, r, res }) => {
      expect(ft.sum(l, r)).toBe(res);
    });
  });

  describe("範囲加算のテスト", () => {
    beforeAll(() => {
      ft = new FenwickTree(11);
      ft.addByRange(0, 3, 1);
      ft.addByRange(7, 10, 2);
      ft.addByRange(2, 9, 3);
    });
    it.each([
      {i: 1, expected: 1},
      {i: 2, expected: 1},
      {i: 3, expected: 4},
      {i: 4, expected: 3},
      {i: 5, expected: 3},
      {i: 6, expected: 3},
      {i: 7, expected: 3},
      {i: 8, expected: 5},
      {i: 9, expected: 5},
      {i: 10, expected: 2}
    ])("値が正しいこと", ({ i, expected }) => {
      expect(ft.sum(i)).toBe(expected);
    });
  });
});
