/**
 * フェニック木
 * 1. 更新頻度と累積和計算の頻度が高い場合に使用
 * 2. 範囲更新頻度が高い場合で配列値を求める場合にも使用
 */
class FenwickTree {

  // 2の目的の場合は、Integerで初期化すること。その場合、計算の都合上、配列数は1多くすること
  constructor(arg) {
    switch(arg.constructor) {
      case Array:
        this.size = arg.length;
        this.data = [0].concat(arg);
        for (let i = 1; i <= this.size; i++) {
          const up = i + (i & -i)
          if (up > this.size) continue;
          this.data[up] += this.data[i];
        }
        break;
      case Number:
        this.size = arg;
        this.data = new Array(arg + 1).fill(0);
        break;
    }
  }

  // 1の目的の場合に使用
  add(pos, value) {
    let idx = pos + 1;
    while (idx <= this.size) {
      this.data[idx] += value;
      idx += idx & -idx;
    }
  }

  /**
   * 2の目的で使用
   * [l, r) に valueを足すことに相当
   * l > rの場合、[0, r)　と [l, size - 1) に valueを足すことに
   */
  addByRange(l, r, value) {
    this.add(l, value);
    this.add(r, -value);
    if (l > r) {
      this.add(0, value);
      this.add(this.size - 1, -value);
    }
  }

  /**
   * 合計
   * 1の目的： [l, r) の合計
   * 1の目的: r = nil: [0, l) の合計
   * 2の目的: l - 1の値の取得
   */
  sum(l, r = null) {
    return r ? this.#sum(r) - this.#sum(l) : this.#sum(l)
  }


  /**
   * 合計
   * [0, r) の合計
   */
  #sum(r) {
    let idx = r;
    let res = 0;
    while (idx > 0) {
      res += this.data[idx];
      idx -= idx & -idx;
    }
    return res;
  }
}

module.exports = FenwickTree;
