class SegmentTree {
  constructor(arg, id_elm, callback) {

    if (Array.isArray(arg)) {
      this.n = arg.length;
    } else if (typeof arg === "number") {
      this.n = arg;
    }
    this.leaf_size = 1;
    while (this.leaf_size < this.n) this.leaf_size <<= 1;

    this.id_elm = id_elm;
    this.ope = callback;
    this.tree = [...Array(2 * this.leaf_size)].map(_ => this.id_elm);

    if (Array.isArray(arg)) {
      arg.forEach((a, i) => this.tree[this.leaf_size + i] = a);
      for (let i = this.leaf_size - 1; i >0; i--) this.#update(i);
    }
  }

  set(pos, value) {
    let idx = this.leaf_size + pos;
    this.tree[idx] = value;
    while (idx > 1) {
      this.#update(idx >>= 1);
    }
  }

  prod(l, r) {
    let left = this.leaf_size + l;
    let right = this.leaf_size + r;
    let res = this.id_elm;
    while (left < right) {
      if (left % 2 === 1) {
        res = this.ope(res, this.tree[left++]);
      }
      if (right % 2 === 1) {
        res = this.ope(res, this.tree[--right]);
      }
      left >>= 1;
      right >>= 1;
    }
    return res;
  }

  #update(idx) {
    this.tree[idx] = this.ope(this.tree[2 * idx], this.tree[2 * idx + 1]);
  }
}

module.exports = SegmentTree;
