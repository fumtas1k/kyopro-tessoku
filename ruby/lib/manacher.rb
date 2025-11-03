# 回文の長さを求める
# O(N) で求められる
def manacher(str)
  # 偶数長の場合も考慮し奇数長になるよう文字列に含まれない"$"を挿入
  bytes = str.chars.join("$").then { "$#{_1}$" }.bytes
  size = bytes.size
  # 中心からの回文の半径
  radius = [0] * size
  center = 0
  r = 0
  while center < size
    r += 1 while center >= r && center + r < size && bytes[center - r] == bytes[center + r]
    radius[center] = r

    i = 1
    # 対称性を利用して center + j の半径を求める
    while center >= i && center + i < size && i + radius[center - i] < r
      radius[center + i] = radius[center - i]
      i += 1
    end

    # i + radius[center - i] が radius[center] 以上の場合 中心centerの半径に入っていないので
    # radius[center + i] は r - i 以上となることまでしかわからない。
    # ここでは、暫定的な値を入れる
    r -= i
    center += i
  end
  # strに$を付加しているので、その部分を抜く。
  # radiusは回文の半径としているが挿入された$も含むためradiusの値は回文の長さ + 1
  radius[1...-1].map(&:pred)
end
