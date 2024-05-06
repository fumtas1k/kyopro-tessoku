// A03

const input = require("fs").readFileSync("/dev/stdin", "utf8").split("\n");
const [N, K] = input[0].split(" ").map(Number);
const P = input[1].split(" ").map(Number);
const Q = new Set(input[2].split(" ").map(Number));

for (const p of P) {
  if (!Q.has(K - p)) continue;
  console.log("Yes");
  return;
}

console.log("No");
