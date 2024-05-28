// B14
// BIT全探索
// 半分全列挙
// 2分探索

const input = require("fs").readFileSync("/dev/stdin", "utf-8").split("\n");
const [N, K] = input[0].split(" ").map(Number);
const A = input[1].split(" ").map(Number);

const n1 = N >> 1;
const n2 = N - n1;

const sumSet1 = new Set([0]);
for (let i = 0; i < (1 << n1); i++) {
  sumSet1.add(
    A.slice(0, n1).filter((_, j) => (i >> j) & 1 === 1).reduce((acc, a) => acc + a, 0)
  );
}

const sumSet2 = new Set([0]);
for (let i = 0; i < (1 << n2); i++) {
  sumSet2.add(
    A.slice(n1, N).filter((_, j) => (i >> j) & 1 === 1).reduce((acc, a) => acc + a, 0)
  );
}

const sumArray2 = [...sumSet2].sort((a, b) => a - b);

for (const sum1 of sumSet1) {
  let left = -1;
  let right = sumArray2.length;
  while (right - left > 1) {
    const mid = (right + left) >> 1;
    const sum = sum1 + sumArray2[mid];
    sum >= K ? right = mid : left = mid;
  }
  if (sum1 + sumArray2[right] === K) {
    console.log("Yes");
    return;
  }
}

console.log("No");
