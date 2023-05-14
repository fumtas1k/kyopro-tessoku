# A26-01
# 素数判定
# 実行時間: 1s以内

def prime?(x)
  return false if x <= 1
  !2.upto(Math.sqrt(x).to_i).any? { x % _1 == 0 }
end

Q = gets.to_i
X = Array.new(Q) { gets.to_i }
X.each { puts prime?(_1) ? "Yes" : "No" }
