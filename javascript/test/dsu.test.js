const { before } = require("node:test");
const DSU = require("../lib/dsu");

describe("DSU", () => {
  let dsu;

  beforeEach(() => dsu = new DSU(10));

  describe("rootのテスト", () => {
    describe("初期値", () => {
      it("自分自身であること", () => {
        expect(dsu.root(7)).toBe(7);
      });
    });
    describe("連結された場合", () => {
      beforeEach(() => {
        dsu.parentOrSize[7] = 0;
        dsu.parentOrSize[0] = -2;
      });
      it("親が返ること", () => {
        expect(dsu.root(7)).toBe(0);
      });
    });
  });

  describe("isSameのテスト", () => {
    describe("同じ親の要素がある場合", () => {
      beforeEach(() => {
        dsu.parentOrSize[2] = 1;
        dsu.parentOrSize[1] = -2;
      });
      it("isSameで親が同じものを同じと判定できる", () => {
        expect(dsu.isSame(1, 2)).toBeTruthy();
      });
    });
  });

  describe("uniteのテスト", () => {
    describe("親が違う場合にuniteを使用した場合", () => {
      it("親が同じになる", () => {
        expect(dsu.isSame(1, 9)).toBeFalsy();
        dsu.unite(1, 9);
        expect(dsu.isSame(1, 9)).toBeTruthy();
      });
    });
  });

  describe("sizeのテスト", () => {
    describe("初期のサイズ", () => {
      it("1であること", () => {
        expect(dsu.size(0)).toBe(1);
      });
    });

    describe("連結後のサイズ", () => {
      beforeEach(() => {
        dsu.unite(0, 1);
        dsu.unite(0, 2);
        dsu.unite(0, 9);
      });
      it("親のサイズが正しいこと", () => {
        expect(dsu.size(0)).toBe(4);
      });
      it("子のサイズが正しいこと", () => {
        expect(dsu.size(9)).toBe(4);
      });
    });
  });

  describe("groupsとrootsのテスト", () => {
    beforeEach(() => {
      dsu.unite(0, 1);
      dsu.unite(0, 2);
      dsu.unite(0, 3);
      dsu.unite(4, 5);
      dsu.unite(5, 6);
      dsu.unite(7, 8);
    });

    describe("groups", () => {
      it("戻り値が正しいこと", () => {
        const expected = new Map([[0, [0, 1, 2, 3]], [4, [4, 5, 6]], [7, [7, 8]], [9, [9]]]);
        expect(dsu.groups()).toEqual(expected);
      });
    });

    describe("roots", () => {
      it("戻り値が正しいこと", () => {
        expect(dsu.roots()).toEqual([0, 4, 7, 9]);
      });
    });
  });
});
