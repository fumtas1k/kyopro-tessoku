# A41
# 後ろから考える
# Tile Coloring
# 実行時間: 1s以内

start_time = Time.now

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

File.open("question/#{File.basename(__FILE__).split(/\.rb$/).first}.txt", "r") do |f|
  N = f.gets.to_i
  S = f.gets.chomp.chars
  puts S.repeat?(3) ? "Yes" : "No"
end

puts "\n処理時間: #{((Time.now - start_time) * 1_000).round(2)} ms"
