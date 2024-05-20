// A21
// 区間DP

const input = require("fs").readFileSync("/dev/stdin", "utf-8").split("\n");
let n = 0;
const N = Number(input[n++]);
const PA = [];
for (let i = 0; i < N; i++) {
  PA.push(input[n++].split(" ").map(Number));
}

const dp = [...Array(N)].map(() => Array(N).fill(0));

for (let di = 0; di < N; di++) {
  for (let i = 0; i + di < N; i++) {
    const j = i + di;
    if (i > 0) {
      let [pl, al] = PA[i - 1];
      pl--;
      const scoreL = i <= pl && pl <= j ? al : 0;
      dp[i - 1][j] = Math.max(dp[i - 1][j], dp[i][j] + scoreL);
    }

    if (j < N - 1) {
      let [pr, ar] = PA[j + 1];
      pr--;
      const scoreR = i <= pr && pr <= j ? ar : 0;
      dp[i][j + 1] = Math.max(dp[i][j + 1], dp[i][j] + scoreR);
    }
  }
}

console.log(dp[0][N - 1]);
