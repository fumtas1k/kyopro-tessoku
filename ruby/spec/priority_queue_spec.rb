require_relative "../lib/priority_queue"

# 優先度付キューのテスト
RSpec.describe PriorityQueue do
  let(:priority_queue) { PriorityQueue.new { |x, y| x.first <= y.first } }
  context "8個の要素をプッシュした場合" do
    before do
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

    it "shiftを2回行うと[2, 6]が取得できる" do
      priority_queue.shift
      expect(priority_queue.shift).to eq [2, 6]
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

    it "1つずつプッシュした場合と同じheapが得られる" do
      expected = PriorityQueue.new { |x, y| x.first <= y.first }
      expected << [9, 2]
      expected << [5, 1]
      expected << [3, 3]
      expected << [6, 5]
      expected << [8, 10]
      expected << [1, 4]
      expected << [4, 9]
      expected << [2, 6]
      expect(priority_queue.send(:heap)).to eq expected.send(:heap)
    end
  end

  context "配列で新規作成した場合" do
    before do
      priority_queue << [9, 2]
      priority_queue << [5, 1]
      priority_queue << [3, 3]
      priority_queue << [6, 5]
      priority_queue << [8, 10]
      priority_queue << [1, 4]
      priority_queue << [4, 9]
      priority_queue << [2, 6]
    end

    it "1つずつプッシュした場合と同じheapが得られる" do
      actual = PriorityQueue.new([
        [9, 2],
        [5, 1],
        [3, 3],
        [6, 5],
        [8, 10],
        [1, 4],
        [4, 9],
        [2, 6],
      ]) { |x, y| x.first <= y.first }
      expect(actual.send(:heap)).to eq priority_queue.send(:heap)
    end
  end

  context "すべてを取り出した場合" do
    before do
      priority_queue << [9, 2]
      priority_queue << [5, 1]
      priority_queue.shift
      priority_queue.shift
    end
    it "heapは空" do
      expect(priority_queue.empty?).to be_truthy
    end
  end
end
