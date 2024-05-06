// A11
// 二分探索法

Array.prototype.binarySearch = function(comparator) {
  let left = -1;
  let right = this.length;
  while (right - left > 1) {
    const mid = (right + left) >> 1;
    if (comparator(this[mid]) > 0) {
      right = mid;
    } else if ((comparator(this[mid]) < 0)) {
      left = mid;
    } else {
      return mid;
    }
  }
  return -1;
}

const input = require("fs").readFileSync("/dev/stdin", "utf8").split("\n");
const [N, X] = input[0].split(" ").map(Number);
const A = input[1].split(" ").map(Number);

console.log(A.binarySearch(mid => mid - X) + 1);
