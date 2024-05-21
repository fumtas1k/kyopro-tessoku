// B21
// 区間DP

const input = require("fs").readFileSync("/dev/stdin", "utf-8").split("\n");
let n = 0;
const N = Number(input[n++]);
const S = input[n++];

const dp = [...Array(N)].map(() => Array(N).fill(1));

for (let i = 0; i < N - 1; i++) {
  if (S[i] === S[i + 1]) dp[i][i + 1] = 2;
}

for (let dl = 2; dl < N; dl++) {
  for (let l = 0; l + dl < N; l++) {
    const r = l + dl;
    dp[l][r] = Math.max(dp[l][r], dp[l + 1][r]);
    dp[l][r] = Math.max(dp[l][r], dp[l][r - 1]);
    if (S[l] === S[r]) dp[l][r] = Math.max(dp[l][r], dp[l + 1][r - 1] + 2);
  }
}
console.log(dp[0][N - 1]);
