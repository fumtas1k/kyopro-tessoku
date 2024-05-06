// 優先度付きキュー

class PriorityQueue {

  constructor(ope = (x, y) => x < y, arr = []) {
    this.heap = arr;
    this.ope = ope;
    this.#heapify();
  }

  size() {
    return this.heap.length;
  }

  first() {
    return this.heap[0];
  }

  isEmpty() {
    return this.heap.length === 0;
  }

  push(item) {
    this.heap.push(item);
    this.#shift_down(0, this.heap.length - 1);
    return this;
  }

  pushAll(arr) {
    arr.forEach((item) => this.push(item));
    return this;
  }

  shift() {
    const last = this.heap.pop();
    if (this.heap.length === 0) return last;
    const res_item = this.heap[0];
    this.heap[0] = last;
    this.#shift_up(0);
    return res_item;
  }
  pop = this.shift;

  #heapify() {
    for (let i = (this.heap.length >> 1) - 1; i >= 0; i--) {
      this.#shift_up(i);
    }
  }

  #shift_up(idx) {
    const start_idx = idx;
    const item = this.heap[idx];
    let child_idx1;
    while ((child_idx1 = 2 * idx + 1) < this.heap.length) {
      const child_idx2 = child_idx1 + 1;
      if (child_idx2 < this.heap.length && !this.ope(this.heap[child_idx1], this.heap[child_idx2])) {
        child_idx1 = child_idx2;
      }
      this.heap[idx] = this.heap[child_idx1];
      idx = child_idx1;
    }
    this.heap[idx] = item;

    this.#shift_down(start_idx, idx);
  }

  #shift_down(start_idx, idx) {
    const item = this.heap[idx];
    while (idx > start_idx) {
      const parent_idx = (idx - 1) >> 1;
      if (this.ope(this.heap[parent_idx], item)) break;
      this.heap[idx] = this.heap[parent_idx];
      idx = parent_idx;
    }
    this.heap[idx] = item;
  }
}

module.exports = PriorityQueue;
