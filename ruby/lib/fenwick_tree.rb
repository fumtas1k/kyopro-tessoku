# フェニック木

# 1. 更新頻度と累積和計算の頻度が高い場合に使用
# 2. 範囲更新頻度が高い場合で配列値を求める場合にも使用
class FenwickTree
  attr_accessor :data, :size

  # 2の目的の場合は、Integerで初期化すること。その場合、計算の都合上、配列数は1多くすること
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

  # 1の目的の場合に使用
  def add(pos, value)
    idx = pos + 1
    while idx <= size
      data[idx] += value
      idx += idx & -idx
    end
  end

  # 2の目的で使用
  # [l, r) に valueを足すことに相当
  # l > rの場合、[0, r)　と [l, size - 1) に valueを足すことに相当
  def add_by_range(l, r, value)
    add(l, value)
    add(r, -value)
    if l > r
      add(0, value)
      add(size - 1, -value)
    end
  end

  # 1の目的： [l, r) の合計
  # 1の目的: r = nil: [0, l) の合計
  # 2の目的: l - 1の値の取得
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
