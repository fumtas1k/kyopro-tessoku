# A26-02
# 素数判定
# 実行時間: 1s以内

MAX = 3 * 10 ** 6
primes = [true] * (MAX + 1)
primes[0, 2] = [false, false]
2.upto(Math.sqrt(MAX).to_i) do |i|
  next unless primes[i]
  (2 * i).step(MAX, i) { primes[_1] = false }
end

Q = gets.to_i
X = Array.new(Q) { gets.to_i }
X.each { puts primes[_1] ? "Yes" : "No" }
