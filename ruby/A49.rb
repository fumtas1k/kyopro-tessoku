# A49
# Beam Search
# Heuristic
# 実行時間: 1s以内

State = Struct.new(:score, :arr, :move, :pre) {
  def <=>(other) = score <=> other.score
}

WIDTH = 2_000
N = 20
T = gets.to_i
PQR = Array.new(T) { gets.split.map(&:to_i).map(&:pred) }
beams = []
beams << [State.new(0, Array.new(N, 0), nil, -1)]

PQR.each_with_index do |pqr, i|
  candidates = []
  beams[i].each_with_index do |state, j|
    sousa_a = state.dup
    sousa_a.arr = state.arr.dup
    sousa_a.move = :A
    sousa_a.pre = j
    pqr.each { sousa_a.arr[_1] += 1 }
    sousa_a.score = sousa_a.arr.count(0)
    candidates << sousa_a

    sousa_b = state.dup
    sousa_b.arr = state.arr.dup
    sousa_b.move = :B
    sousa_b.pre = j
    pqr.each { sousa_b.arr[_1] -= 1 }
    sousa_b.score = sousa_b.arr.count(0)
    candidates << sousa_b
  end
  candidates.sort!.reverse!
  size = [WIDTH, candidates.size].min
  beams << candidates[0, size]
end

ans = []
pos = 0
T.downto(1) do |i|
  ans << beams[i][pos].move
  pos = beams[i][pos].pre
end

puts ans.reverse
