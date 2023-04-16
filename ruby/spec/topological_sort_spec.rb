require_relative "../lib/topological_sort.rb"

# トポロジカルソートのテスト
RSpec.describe TopologicalSort do
  describe "要素に重複がない場合" do
    context "順番が一意に定る場合" do
      let(:xy) {
        [
          [3, 1],
          [2, 3]
        ]
      }
      let(:topological_sort) { TopologicalSort.new(3) }
      it "整列された配列が得られる" do
        xy.each { topological_sort.add(*_1) }
        expect(topological_sort.sort).to eq [3, 1, 2]
      end
    end

    context "順番が一意に定まらない場合" do
      let(:xy) {
        [
          [3, 1],
          [3, 2]
        ]
      }
      let(:topological_sort) { TopologicalSort.new(3) }
      it "空の配列が得られる" do
        xy.each { topological_sort.add(*_1) }
        expect(topological_sort.sort).to eq []
      end
    end
  end

  describe "要素に重複がある場合" do
    context "順番が一意に定る場合" do
      let(:xy) {
        [
          [3, 1],
          [3, 1],
          [2, 3],
          [2, 3]
        ]
      }
      let(:topological_sort) { TopologicalSort.new(3) }
      it "整列された配列が得られる" do
        xy.each { topological_sort.add(*_1) }
        expect(topological_sort.sort).to eq [3, 1, 2]
      end
    end

    context "順番が一意に定まらない場合" do
      let(:xy) {
        [
          [3, 1],
          [3, 1],
          [3, 2],
          [3, 2]
        ]
      }
      let(:topological_sort) { TopologicalSort.new(3) }
      it "空の配列が得られる" do
        xy.each { topological_sort.add(*_1) }
        expect(topological_sort.sort).to eq []
      end
    end
  end
end
