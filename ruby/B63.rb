# B63
# 幅優先探索
# Breadth First Search(BFS)

R, C = gets.split.map(&:to_i)
SY, SX = gets.split.map(&:to_i).map(&:pred)
GY, GX = gets.split.map(&:to_i).map(&:pred)
G = Array.new(R) { gets.chomp.chars }

log = [[SY, SX, 0]]
G[SY][SX] = "#"
until log.empty?
  r, c, cnt = log.shift
  if [r, c] == [GY, GX]
    puts cnt
    break
  end
  [[1, 0], [0, 1], [-1, 0], [0, -1]].each do |dr, dc|
    nr, nc = r + dr, c + dc
    next unless nr.between?(0, R - 1) && nc.between?(0, C - 1)
    next unless G[nr][nc] == "."
    G[nr][nc] = "*"
    log << [nr, nc, cnt + 1]
  end
end
