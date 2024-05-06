// A02

const input = require("fs").readFileSync("/dev/stdin", "utf8").split("\n");
const [N, X] = input[0].split(" ").map(Number);
const A = input[1].split(" ").map(Number);
console.log(A.includes(X) ? "Yes" : "No");
