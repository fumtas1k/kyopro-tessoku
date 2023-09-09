# B26
# 素数判定
# 実行時間: 1s以内

N = gets.to_i

primes = [true] * (N + 1)
primes[0] = primes[1] = false

2.upto(Math.sqrt(N).to_i) do |i|
  next unless primes[i]
  (2 * i).step(N, i) do |j|
    next unless primes[j]
    primes[j] = false
  end
end

puts (2 .. N).filter { primes[_1] }
