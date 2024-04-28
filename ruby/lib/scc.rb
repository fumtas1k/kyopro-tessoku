# 強連結成分(Strongly Connected Components)

class SCC
  attr_reader :size, :edges
  def initialize(n)
    @size = n
    @edges = Array.new(size) { [] }
  end

  def add_edge(from, to)
    edges[from] << to
  end

  def add_edges(arr)
    arr.each { add_edge(_1, _2) }
  end

  def scc
    group_num, ids = scc_ids
    groups = Array.new(group_num) { [] }
    ids.each_with_index { groups[_1] << _2 }
    groups
  end

  private
  def scc_ids
    now_ord = group_num = 0
    visited = []
    low = []
    ord = []
    ids = []

    dfs =-> from do
      low[from] = ord[from] = now_ord
      now_ord += 1
      visited << from

      edges[from].each do |to|
        if ord[to]
          low[from] = [low[from], ord[to]].min
        else
          dfs.call(to)
          low[from] = [low[from], low[to]].min
        end
      end
      return unless low[from] == ord[from]
      while (to = visited.pop)
        # back edgeやcross edgeはordが小さい頂点と結ばれることがあるため、
        # 頂点の SCC id が確定している場合にも頂点の lowlink が更新されてしまう可能性があるため
        # ordをlowlinkの更新に影響しない値に置き換えておく。
        ord[to] = size
        ids[to] = group_num
        break if from == to
      end
      group_num += 1
    end

    size.times do |i|
      next if ord[i]
      dfs.call(i)
    end

    ids.map! { group_num - _1 - 1 }

    [group_num, ids]
  end
end
