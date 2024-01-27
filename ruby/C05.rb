# C05

N = gets.to_i

puts (N - 1).to_s(2).rjust(10, "0").tr("01", "47")
