# A69
# 二部マッチング
# Ford-Fulkerson法

require_relative "lib/max_flow"

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N = f.gets.to_i
  C = Array.new(N) { f.gets.chomp.chars }
  max_flow = MaxFlow.new(2 * N + 2)
  C.each_with_index do |row, i|
    row.each_with_index do |c, j|
      max_flow.add_edge(i, N + j, 1)
    end
  end
  1.upto(N) do |i|
    max_flow.add_edge(2 * N + 1, i, 1)
    max_flow.add_edge(N + i, 2 * N + 2, 1)
  end
  puts max_flow.max_flow(2 * N + 1, 2 * N + 2)
end
