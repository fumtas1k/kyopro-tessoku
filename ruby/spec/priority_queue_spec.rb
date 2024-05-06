require_relative "../lib/priority_queue"

# 優先度付キューのテスト
RSpec.describe PriorityQueue do
  let(:priority_queue) { PriorityQueue.new { |x, y| x.first < y.first } }
  context "8個の要素をプッシュした場合" do
    before do
      priority_queue.heap.clear
      priority_queue << [9, 2]
      priority_queue << [5, 1]
      priority_queue << [3, 3]
      priority_queue << [6, 5]
      priority_queue << [8, 10]
      priority_queue << [1, 4]
      priority_queue << [4, 9]
      priority_queue << [2, 6]
    end

    it "sizeで要素数8が取得できる" do
      expect(priority_queue.size).to eq 8
    end

    it "firstで[1, 4]が得られて要素数は変わらない" do
      expect(priority_queue.first).to eq [1, 4]
      expect(priority_queue.size).to eq 8
    end

    it "shiftで[1, 4]が取得でき要素数が7になる" do
      expect(priority_queue.shift).to eq [1, 4]
      expect(priority_queue.size).to eq 7
    end

    it "shiftで得られる値が正しいこと" do
      [
        [1, 4],
        [2, 6],
        [3, 3],
        [4, 9],
        [5, 1],
        [6, 5],
        [8, 10],
        [9, 2],
      ].each do |expected|
        expect(priority_queue.shift).to eq expected
      end
    end
  end

  context "まとめてプッシュした場合" do
    before do
      priority_queue.push_all([
        [9, 2],
        [5, 1],
        [3, 3],
        [6, 5],
        [8, 10],
        [1, 4],
        [4, 9],
        [2, 6],
      ])
    end

    it "shiftで得られる値が正しいこと" do
      [
        [1, 4],
        [2, 6],
        [3, 3],
        [4, 9],
        [5, 1],
        [6, 5],
        [8, 10],
        [9, 2],
      ].each do |expected|
        expect(priority_queue.shift).to eq expected
      end
    end
  end

  context "配列で新規作成した場合" do
    it "shiftで得られる値が正しいこと" do
      actual = PriorityQueue.new([
        [9, 2],
        [5, 1],
        [3, 3],
        [6, 5],
        [8, 10],
        [1, 4],
        [4, 9],
        [2, 6],
      ]) { |x, y| x.first < y.first }

      [
        [1, 4],
        [2, 6],
        [3, 3],
        [4, 9],
        [5, 1],
        [6, 5],
        [8, 10],
        [9, 2],
      ].each do |expected|
        expect(actual.shift).to eq expected
      end
    end
  end

  context "すべてを取り出した場合" do
    before do
      priority_queue << [9, 2]
      priority_queue << [5, 1]
      priority_queue.shift
      priority_queue.pop
    end
    it "heapは空" do
      expect(priority_queue.empty?).to be_truthy
    end
  end
end
