# A49
# Beam Search
# Heuristic
# 実行時間: 1s以内

State = Struct.new(:score, :x, :last_move, :last_pos) {
  def <=>(other)
    score <=> other.score
  end
}

WIDTH = 2_000
N = 20
T = gets.to_i
PQR = Array.new(T) { gets.split.map(&:to_i) }

num_state = []
beam = []

num_state[0] = 1
beam << [State.new(0, Array.new(N + 1, 0), nil, -1)]
PQR.each_with_index do |pqr, i|
  candidate = []
  num_state[i].times do |j|
    state_a = beam[i][j].clone
    state_a.x = beam[i][j].x.clone
    state_a.last_move = "A"
    state_a.last_pos = j
    pqr.each { state_a.x[_1] += 1 }
    state_a.score += state_a.x.count(0)
    candidate << state_a

    state_b = beam[i][j].clone
    state_b.x = beam[i][j].x.clone
    state_b.last_move = "B"
    state_b.last_pos = j
    pqr.each { state_b.x[_1] -= 1 }
    state_b.score += state_b.x.count(0)
    candidate << state_b
  end

  candidate.sort!.reverse!

  num_state << [WIDTH, candidate.size].min
  beam << candidate[0, num_state[-1]]
end

ans = []
pos = 0
T.downto(1) do |i|
  ans[i - 1] = beam[i][pos].last_move
  pos = beam[i][pos].last_pos
end

puts ans
