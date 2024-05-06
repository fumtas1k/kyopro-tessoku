# スライド最小値・最大値
# 最小値 = SlidingWindow.new(data, window_size, &:<)
# 最大値 = SlidingWindow.new(data, window_size, &:>)
class SlidingWindow
  attr_reader :data, :ope, :window, :window_size

  def initialize(data, window_size = nil, &block)
    @data = data
    @ope = block
    @window_size = window_size
  end

  # 実行
  # match 区間幅ピッタリか？
  # window_size 区間幅
  # 結果
  def prod(match = true, window_size = @window_size)
    res = []
    @window = []
    (data.size + (match ? 0 : window_size - 1)).times do |i|
      set_window(i)
      next if match && i < window_size - 1
      res << data[window[0]]
    end
    res
  end

  private
  # 範囲設定
  # idx インデックス
  def set_window(idx)
    window.shift if window_size <= idx && window[0] <= idx - window_size
    return if idx >= data.size
    # 追加する値より大きい(最小の場合)、もしくは小さい(最大の場合)値は不要のため捨てる
    window.pop while !window.empty? && ope.call(data[idx], data[window[-1]])
    window << idx
  end
end
