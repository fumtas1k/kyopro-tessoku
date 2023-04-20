# A49
# Beam Search
# Heuristic
# 実行時間: 1s以内

start_time = Time.now

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  T = f.gets.to_i
  PQR = Array.new(T) { f.gets.split.map { _1.to_i - 1 } }
end

State = Struct.new(:score, :x, :last_move, :last_pos) {
  def <=>(other)
    other.is_a?(self.class) ? score <=> other.score : nil
  end
}

WIDTH = 1000
N = 20
num_state = [1]
beam = Array.new(T + 1) { [] }
beam[0][0] = State.new(0, [0] * N, nil, nil)

PQR.each_with_index do |(p, q, r), i|
  candidate = []
  num_state[i].times do |j|
    ope_a = beam[i][j].clone
    ope_a.x = ope_a.x.clone
    ope_a.last_move = "A"
    ope_a.last_pos = j
    ope_a.x[p] += 1
    ope_a.x[q] += 1
    ope_a.x[r] += 1
    ope_a.score = ope_a.x.count(0)

    ope_b = beam[i][j].clone
    ope_b.x = ope_b.x.clone
    ope_b.last_move = "B"
    ope_b.last_pos = j
    ope_b.x[p] += 1
    ope_b.x[q] += 1
    ope_b.x[r] += 1
    ope_b.score = ope_b.x.count(0)

    candidate << ope_a
    candidate << ope_b
  end

  candidate.sort!.reverse!

  num_state[i + 1] = [WIDTH, candidate.size].min
  beam[i + 1] = candidate[0, num_state[i + 1]]
end

current_place = 0
ans = []
T.downto(1) do |i|
  ans[i] = beam[i][current_place].last_move
  current_place = beam[i][current_place].last_pos
end

puts ans[1..]

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
