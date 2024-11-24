# 与えられた文字列に対してZアルゴリズムを適用し、各位置から始まる接頭辞の最長一致長を計算します。
#
# @param [String] str 処理対象の文字列
# @return [Array<Integer>] 各位置から始まる接頭辞の最長一致長を格納した配列
#
# Zアルゴリズムは、文字列の各位置から始まる接頭辞の最長一致長を効率的に計算するためのアルゴリズムです。
# 例えば、文字列 "abacaba" に対してこのアルゴリズムを適用すると、結果は [7, 0, 1, 0, 3, 0, 1] となります。
def z_algorithm(str)
  return [] if str.empty?
  sizes = [0] * str.size
  sizes[0] = str.size
  top = 1
  cnt = 0
  while top < str.size
    cnt += 1 while top + cnt < str.size && str[top + cnt] == str[cnt]
    sizes[top] = cnt

    if cnt.zero?
      top += 1
      next
    end

    i = 1
    while top + i < str.size && i + sizes[i] < cnt
      sizes[top + i] = sizes[i]
      i += 1
    end
    top += i
    cnt -= i
  end
  return sizes
end
