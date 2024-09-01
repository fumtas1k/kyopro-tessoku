# B24
# セグメント木
# 復元(セグメント木を使用することで最長増加部分列を例示できる)
# 最長増加部分列
# 実行時間: 1s以内

class SegTree
  attr_accessor :leaf_size, :id_elm, :ope, :tree, :size

  def initialize(n, id_elm, &ope)
    @size = n
    @id_elm = id_elm
    @ope = ope
    @leaf_size = 1 << (@size - 1).bit_length
    @tree = Array.new(2 * @leaf_size, @id_elm)
  end

  def get(pos)
    tree[leaf_size + pos]
  end
  alias [] get

  # 更新
  # pos arrのindex
  # value 更新する値
  def set(pos, value)
    idx = leaf_size + pos
    tree[idx] = value
    while idx > 1
      update(idx >>= 1)
    end
  end
  alias []= set

  # 値の取得
  # [0, size)
  def all_prod
    tree[1]
  end

  # 値の取得
  # [l, r)　求めたい半開区間
  def prod(l, r)
    left = leaf_size + l
    right = leaf_size + r
    sml = id_elm
    smr = id_elm
    while left < right
      if left[0] == 1
        sml = ope.call(sml, tree[left])
        left += 1
      end
      if right[0] == 1
        right -= 1
        smr = ope.call(tree[right], smr)
      end
      left >>= 1
      right >>= 1
    end
    ope.call(sml, smr)
  end

  private
  def update(idx)
    tree[idx] = ope.call(tree[2 * idx], tree[2 * idx + 1])
  end
end

MAX = 5 * 10 ** 5
N = gets.to_i
XY = Array.new(N) { gets.split.map(&:to_i) }.sort_by { [_1, -_2] }.uniq

# [lis, idx]
st = SegTree.new(MAX + 1, [0, -1]) { |x, y| x.first >= y.first ? x : y }
pre = []
XY.each_with_index do |(x, y), i|
  lis, idx = st.prod(0, y + 1)
  next if idx != -1 && XY[idx][1] == y
  pre[i] = idx
  st.set(y, [lis + 1, i])
end

lis, idx = st.all_prod
puts lis

# 最長増加部分列の復元
# log = [XY[idx]]
# while pre[idx] != -1
#   idx = pre[idx]
#   log << XY[idx]
# end
# log.reverse!
