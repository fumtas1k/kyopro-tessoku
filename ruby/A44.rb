# A44
# データの持ち方を工夫する
# 実行時間: 1s以内

N, Q = gets.split.map(&:to_i)
QUERY = Array.new(Q) { gets.split.map(&:to_i) }

A = [*0 .. N]
rev = false
QUERY.each do |q|
  case q[0]
  when 1
    if rev
      A[N - q[1] + 1] = q[2]
    else
      A[q[1]] = q[2]
    end
  when 2
    rev = !rev
  when 3
    puts rev ? A[N - q[1] + 1] : A[q[1]]
  end
end
