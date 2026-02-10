# Fenwick Tree（BIT）と座標圧縮を用いたSortedMultiSet
#
# @example
#   ss = FwtSortedMultiSet.new([1, 3, 5, 7, 9])
#   ss.add(3)
#   ss.add(3)
#   ss.add(5)
#   ss.kth(1)       #=> 3
#   ss.delete_at(2) # 2番目の「3」を削除
#   ss.count_range(3, 7) #=> 2 (3と5)
#
# @note 扱える要素は {#initialize} 時に渡した +sorted+ 配列に含まれるもののみ。
class FwtSortedMultiSet
  include Enumerable

  # @return [Integer] セット内の総要素数（重複含む）
  attr_reader :size

  # @param sorted [Array<Comparable>] 操作対象となるユニークでソート済みの要素の配列
  def initialize(sorted)
    @sorted = sorted
    @n = sorted.size
    @data = [0] * (@n + 1)
    @indexes = sorted.each_with_index.to_h
    @size = 0
    @bw = 1 << (@n.bit_length - 1)
  end

  # 要素を1つセットに追加する
  # @param key [Comparable] 追加する要素
  # @return [void]
  # @note 計算量: O(log N)
  def add(key)
    @size += 1
    _update(key, 1)
  end

  # 要素を1つセットから削除する
  # @param key [Comparable] 削除する要素
  # @return [Boolean] 削除に成功したか（要素が存在しない場合はfalse）
  # @note 計算量: O(log N)
  def delete(key)
    return false if count(key).zero?
    @size -= 1
    _update(key, -1)
    true
  end

  # 指定した順位の要素を削除し、その要素を返す
  # @param rank [Integer] 求める順位（1-origin）
  # @return [Comparable, nil] 削除された要素（範囲外ならnil）
  # @note 計算量: O(log N)
  def delete_at(rank)
    return nil if rank < 1 || rank > @size
    key = kth(rank)
    delete(key)
    key
  end

  # 指定した要素をすべてセットから削除する
  # @param key [Comparable] 削除する要素
  # @return [void]
  # @note 計算量: O(log N)
  def delete_all(key)
    cnt = self[key]
    return if cnt.zero?
    @size -= cnt
    _update(key, -cnt)
  end

  # key 以上の最初の要素が、小さい方から何番目か(1-origin)を返す
  # @param key [Comparable] 基準となる値
  # @return [Integer] 順位（全て key 未満なら size + 1）
  # @note 計算量: O(log N)
  def lower_bound(key)
    idx = @sorted.bsearch_index { _1 >= key }
    idx ? _sum(idx) + 1 : @size + 1
  end

  # key より大きい最初の要素が、小さい方から何番目か(1-origin)を返す
  # @param key [Comparable] 基準となる値
  # @return [Integer] 順位（全て key 以下なら size + 1）
  # @note 計算量: O(log N)
  def upper_bound(key)
    idx = @sorted.bsearch_index { _1 > key }
    idx ? _sum(idx) + 1 : @size + 1
  end

  # 指定範囲 [left, right] に含まれる要素の個数を返す
  # @param left [Comparable] 閉区間の左端
  # @param right [Comparable] 閉区間の右端
  # @return [Integer] 要素数
  # @note 計算量: O(log N)
  def count_range(left, right)
    l_idx = @sorted.bsearch_index { _1 >= left }
    r_idx = @sorted.bsearch_index { _1 > right }
    return 0 if l_idx.nil? || (r_idx && l_idx >= r_idx)
    _sum(r_idx || @n) - _sum(l_idx)
  end

  # セット内で rank 番目に小さい要素を返す
  # @param rank [Integer] 求める順位（1-origin）
  # @return [Comparable, nil] 要素
  # @note 計算量: O(log N)
  def kth(rank)
    return nil if rank < 1 || rank > @size
    i = 0
    w = @bw
    while w > 0
      ni = i + w
      if ni <= @n && @data[ni] < rank
        i = ni
        rank -= @data[i]
      end
      w >>= 1
    end
    @sorted[i]
  end

  # @return [Comparable, nil] 最小値
  def min = kth(1)

  # @return [Comparable, nil] 最大値
  def max = kth(@size)

  # maybe_key 以下の最大の要素を返す（maybe_key自身も含む）
  # @param maybe_key [Comparable]
  # @return [Comparable, nil]
  def prev(maybe_key)
    rank = upper_bound(maybe_key) - 1  # maybe_key以下の要素数 = 最大のものの順位
    rank >= 1 ? kth(rank) : nil
  end

  # maybe_key 以上の最小の要素を返す（maybe_key自身も含む）
  # @param maybe_key [Comparable]
  # @return [Comparable, nil]
  def next(maybe_key)
    rank = lower_bound(maybe_key)  # maybe_key以上の最小の要素の順位
    rank <= @size ? kth(rank) : nil
  end

  # maybe_key 未満の最大の要素を返す（strictly less than）
  # @param maybe_key [Comparable]
  # @return [Comparable, nil]
  def prev_strict(maybe_key)
    rank = lower_bound(maybe_key) - 1
    rank >= 1 ? kth(rank) : nil
  end

  # maybe_key より大きい最小の要素を返す（strictly greater than）
  # @param maybe_key [Comparable]
  # @return [Comparable, nil]
  def next_strict(maybe_key)
    rank = upper_bound(maybe_key)
    rank <= @size ? kth(rank) : nil
  end

  # 指定した要素の個数を返す
  # @param key [Comparable]
  # @return [Integer] 個数
  def count(key)
    idx = @indexes[key]
    return 0 unless idx
    _sum(idx + 1) - _sum(idx)
  end
  alias [] count

  # セットが空かどうか
  # @return [Boolean]
  def empty? = @size.zero?

  # 小さい順に要素を列挙する
  # @yield [Comparable] 要素を昇順に yield
  # @note 計算量: O(N log N)
  def each
    return to_enum(:each) unless block_given?
    return if @size.zero?

    prev_sum = 0
    @sorted.each_with_index do |val, idx|
      cur_sum = _sum(idx + 1)
      (cur_sum - prev_sum).times { yield val }
      prev_sum = cur_sum
    end
  end

  private

  # BITを更新する
  def _update(key, diff)
    i = @indexes[key] + 1
    while i <= @n
      @data[i] += diff
      i += i & -i
    end
  end

  # 先頭から r 番目までの累積和を返す
  def _sum(r)
    res = 0
    while r > 0
      res += @data[r]
      r -= r & -r
    end
    res
  end
end
