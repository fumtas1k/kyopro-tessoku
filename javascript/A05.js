// A05

const input = require("fs").readFileSync("/dev/stdin", "utf8").split("\n");
const [N, K] = input[0].split(" ").map(Number);

let cnt = 0;
for (let i = 1; i <= Math.min(N, K); i++) {
  for (let j = 1; j <= Math.min(N, K - i); j++) {
    if (i + j >= K) break;
    if (K - (i + j) <= N) cnt++;
  }
}

console.log(cnt);
