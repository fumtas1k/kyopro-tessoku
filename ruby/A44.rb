# A44
# データの持ち方を工夫する
# 実行時間: 1s以内

N, Q = gets.split.map(&:to_i)
QUERY = Array.new(Q) { gets.split.map(&:to_i) }
A = [*0 .. N]
rev = false
QUERY.each do |q|
  case q
  in [1, x, y]
    if rev
      A[N - x + 1] = y
    else
      A[x] = y
    end
  in [2]
    rev = !rev
  in [3, x]
    puts rev ? A[N - x + 1] : A[x]
  end
end
