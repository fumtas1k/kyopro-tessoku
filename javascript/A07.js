// A07
// いもす法

const input = require("fs").readFileSync("/dev/stdin", "utf8").split("\n");
const D = Number(input[0]);
const N = Number(input[1]);
const imos = new Array(D + 1).fill(0);

for (let i = 0; i < N; i++) {
  const [l, r] = input[2 + i].split(" ").map(Number).map(n => n - 1);
  imos[l]++;
  imos[r + 1]--;
}

for (let i = 0; i < D; i++) imos[i + 1] += imos[i];

console.log(imos.slice(0, D).join("\n"));
