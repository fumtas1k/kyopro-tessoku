# A44
# データの持ち方を工夫する
# 実行時間: 1s以内

N, Q = gets.split.map(&:to_i)
QUERY = Array.new(Q) { gets.split.map(&:to_i) }

A = [*0 .. N]
is_reverse = false
QUERY.each do |q|
  case q[0]
  when 1
    if is_reverse
      A[N - q[1] + 1] = q[2]
    else
      A[q[1]] = q[2]
    end
  when 2
    is_reverse = !is_reverse
  when 3
    puts is_reverse ? A[N - q[1] + 1] : A[q[1]]
  end
end