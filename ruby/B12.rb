# B12
# 答えで二分探索

MOD = 10 ** 3
MAX = ((100000.pow(1 / 3r)) * MOD).ceil
def calc(x) = (x / MOD.to_f) ** 3 + x / MOD.to_f

N = gets.to_i
puts (1 .. MAX).bsearch { calc(_1) >= N } / MOD.to_f
