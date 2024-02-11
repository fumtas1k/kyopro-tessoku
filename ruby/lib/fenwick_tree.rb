# フェニック木

class FenwickTree
  attr_accessor :data, :size

  # imos法を使用する場合は、配列数を1つ多くして初期化する必要がある（配列ではなく数値での初期化)
  # imos法では、値の入力は、imosメソッドで行う
  def initialize(arg)
    case arg
    when Array
      @size = arg.size
      @data = [0].concat(arg)
      1.upto(@size) do |i|
        up = i + (i & -i)
        next if up > @size
        @data[up] += @data[i]
      end
    when Integer
      @size = arg
      @data = [0] * (@size + 1)
    end
  end

  def add(pos, value)
    idx = pos + 1
    while idx <= size
      data[idx] += value
      idx += idx & -idx
    end
  end

  # imos法
  # [l, r) に valueを足す
  # l > rの場合、[0, r)　と [l, size - 1) に valueを足す
  def imos(l, r, value)
    add(l, value)
    add(r, -value)
    if l > r
      add(0, value)
      add(size - 1, -value)
    end
  end

  # [l, r) の合計
  # r = nil: [0, l) の合計、　imos法の場合は、l - 1の値の取得
  def sum(l, r = nil)
    r ? _sum(r) - _sum(l) : _sum(l)
  end

  # 合計
  # [0, r) の合計
  def _sum(r)
    idx = r
    res = 0
    while idx > 0
      res += data[idx]
      idx -= idx & -idx
    end
    res
  end
end
