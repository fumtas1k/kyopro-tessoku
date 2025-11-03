# 回文の長さを求める
# O(N) で求められる
def manacher(str)
  # 偶数長の場合も考慮し奇数長になるよう文字列に含まれない"$"を挿入
  bytes = str.chars.join("$").then { "$#{_1}$" }.bytes
  size = bytes.size
  # 中心iの回文の半径
  radius = [0] * size
  i = 0
  loop do
    # 中心がiの半径を求める
    radius[i] += 1 while i - radius[i] >= 0 &&
      i + radius[i] < size &&
      bytes[i - radius[i]] == bytes[i + radius[i]]

    j = 1
    # 対称性を利用して i + j の半径を求める
    while i - j >= 0 && i + j < size && j + radius[i - j] < radius[i]
      radius[i + j] = radius[i - j]
      j += 1
    end

    break if i + j == size

    # k + radius[i - j] が radius[i] 以上の場合 中心iの半径に入っていないので
    # radius[i + j] は radius[i] - j 以上となることまでしかわからない。
    # ここでは、暫定的な値を入れる
    radius[i + j] = radius[i] - j
    i += j
  end
  # strに$を付加しているので、その部分を抜く。
  # radiusは回文の半径としているが挿入された$も含むためradiusの値は回文の長さ + 1
  radius[1...-1].map(&:pred)
end
