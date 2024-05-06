// A04

const input = require("fs").readFileSync("/dev/stdin", "utf8").split("\n");
const N = Number(input[0]);
console.log(N.toString(2).padStart(10, "0"));
