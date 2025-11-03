# 与えられた文字列に対してZアルゴリズムを適用し、各位置から始まる接頭辞の最長一致長を計算します。
#
# @param [String] str 処理対象の文字列
# @return [Array<Integer>] 各位置から始まる接頭辞の最長一致長を格納した配列
#
# Zアルゴリズムは、文字列の各位置から始まる接頭辞の最長一致長を効率的に計算するためのアルゴリズムです。
# 例えば、文字列 "abacaba" に対してこのアルゴリズムを適用すると、結果は [7, 0, 1, 0, 3, 0, 1] となります。
def z_algorithm(str)
  return [] if str.empty?
  # 高速化のためにバイト列として扱う
  str = str.bytes

  n = str.size
  z = [0] * n
  z[0] = n
  l = 1
  cnt = 0
  while l < n
    cnt += 1 while l + cnt < n && str[cnt] == str[l + cnt]
    z[l] = cnt

    next l += 1 if cnt.zero?

    dl = 1
    while l + dl < n && dl + z[dl] < cnt
      z[l + dl] = z[dl]
      dl += 1
    end
    l += dl
    cnt -= dl
  end
  z
end
