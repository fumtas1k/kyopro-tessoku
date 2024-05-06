// A12
// 二分探索

Array.prototype.sum = function(fn = n => n) {
  return this.reduce((acc, i) => acc + fn(i), 0);
}
const binarySearch = (start, end, comparator, arr = null) => {
  let left = start;
  let right = end;
  while (right - left > 1) {
    const mid = (right + left) >> 1;
    comparator(arr ? arr[mid] : mid) ? right = mid : left = mid;
  }
  return right;
}

const input = require("fs").readFileSync("/dev/stdin", "utf8").split("\n");
const [N, K] = input[0].split(" ").map(Number);
const A = input[1].split(" ").map(Number);

const copy_cnt = time => A.sum(a => Math.floor(time / a));

const ans = binarySearch(0, 10 ** 9, mid => copy_cnt(mid) >= K);

console.log(ans);
