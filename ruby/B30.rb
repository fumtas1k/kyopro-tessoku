# B30
# フェルマーの小定理
# Combination 組み合わせ
# 実行時間: 1s以内

M = 10 ** 9 + 7
H, W = gets.split.map(&:to_i)

class Comb
  attr_accessor :fract, :fract_inv, :mod

  def initialize(mod)
    @mod = mod
    @fract = [1]
    @fract_inv = [1]
  end

  def calc_fract(i)
    return fract[i] if fract[i]
    fract[i] = (calc_fract(i - 1) * i) % mod
  end

  def calc_fract_inv(i)
    return fract_inv[i] if fract_inv[i]
    fract_inv[i] = calc_fract_inv(i - 1) * i.pow(mod - 2, mod) % mod
  end

  def ncr(n, r)
    ((calc_fract(n) * calc_fract_inv(n - r)) % mod * calc_fract_inv(r)) % mod
  end
end


comb = Comb.new(M)
puts comb.ncr(H + W - 2, H - 1)
