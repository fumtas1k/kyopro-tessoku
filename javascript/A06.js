// A06
// 累積和

Array.prototype.scan = function(fn = (acc, n) => acc + n, initialValue = 0) {
  const res = [initialValue];
  for (let i = 0; i < this.length; i++) {
    res.push(fn(res[i], this[i]))
  }
  return res;
}

const input = require("fs").readFileSync("/dev/stdin", "utf8").split("\n");
const [N, Q] = input[0].split(" ").map(Number);
const A = input[1].split(" ").map(Number);
const csum = A.scan();

const ans = [];
for (let i = 0; i < Q; i++) {
  const [l, r] = input[2 + i].split(" ").map(Number);
  ans.push(csum[r] - csum[l - 1]);
}

console.log(ans.join("\n"));
