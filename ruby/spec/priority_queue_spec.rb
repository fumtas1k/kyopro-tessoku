require_relative "../lib/priority_queue"

# 優先度付キューのテスト
RSpec.describe PriorityQueue do
  let(:priority_queue) { PriorityQueue.new }
  context "8個の要素をプッシュした場合" do
    before do
      priority_queue.push([9, 2])
      priority_queue.push([5, 1])
      priority_queue.push([3, 3])
      priority_queue.push([6, 5])
      priority_queue.push([8, 10])
      priority_queue.push([1, 4])
      priority_queue.push([4, 9])
      priority_queue.push([2, 6])
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

    it "1つずつプッシュした場合と同じqueueが得られる" do
      expected = PriorityQueue.new
      expected.push([9, 2])
      expected.push([5, 1])
      expected.push([3, 3])
      expected.push([6, 5])
      expected.push([8, 10])
      expected.push([1, 4])
      expected.push([4, 9])
      expected.push([2, 6])
      expect(priority_queue.queue).to eq expected.queue
    end
  end

  context "配列で新規作成した場合" do
    before do
      priority_queue.push([9, 2])
      priority_queue.push([5, 1])
      priority_queue.push([3, 3])
      priority_queue.push([6, 5])
      priority_queue.push([8, 10])
      priority_queue.push([1, 4])
      priority_queue.push([4, 9])
      priority_queue.push([2, 6])
    end

    it "1つずつプッシュした場合と同じqueueが得られる" do
      actual = PriorityQueue.from([
        [9, 2],
        [5, 1],
        [3, 3],
        [6, 5],
        [8, 10],
        [1, 4],
        [4, 9],
        [2, 6],
      ])
      expect(actual.queue).to eq priority_queue.queue
    end
  end
end
