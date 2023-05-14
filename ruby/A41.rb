# A41
# 後ろから考える
# Tile Coloring
# 実行時間: 1s以内

module AddRepeatToArray
  refine Array do
    def repeat?(n)
      cnt, pre = 0, nil
      each do |c|
        if c != pre
          cnt, pre = 1, c
        else
          cnt += 1
        end
        return true if n == cnt
      end
      false
    end
  end
end

using AddRepeatToArray

N = gets.to_i
S = gets.chomp.chars
puts S.repeat?(3) ? "Yes" : "No"
