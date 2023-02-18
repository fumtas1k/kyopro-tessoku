require_relative "../lib/segment_tree"

RSpec.describe SegmentTree do
  describe "加算" do
    let(:arr) { [3, 7, 5, 2, 1, 4, 10, 8, 9, 6] }
    let(:segment_tree) { SegmentTree.new(arr, 0){|a, b| [a, b].sum} }

    context "要素数が10個の配列の場合" do
      it "葉の数は16" do
        expect(segment_tree.leaf_size).to eq 16
      end
    end

    context "queryで範囲を指定した場合" do
      it "その範囲の合計が得られる" do
        expect(segment_tree.query(1, 6)).to eq arr[0, 5].sum
      end
    end

    context "要素の値を更新した場合" do
      before do
        segment_tree.update(2, 0)
      end
      it "queryで更新後の合計が得られる" do
        expect(segment_tree.query(1, 6)).to eq arr[0, 5].sum - 7
      end
    end
  end

  describe "乗算" do
    let(:arr) { [3, 7, 5, 2, 1, 4, 10, 8, 9, 6] }
    let(:segment_tree) { SegmentTree.new(arr, 1){|a, b| a * b} }

    context "queryで範囲を指定した場合" do
      it "その範囲の値を掛けた値が得られる" do
        expect(segment_tree.query(1, 6)).to eq arr[0, 5].reduce(:*)
      end
    end

    context "要素の値を更新した場合" do
      before do
        segment_tree.update(2, 1)
      end
      it "queryで指定した範囲の更新後の値の掛けた値が得られる" do
        expect(segment_tree.query(1, 6)).to eq arr[0, 5].reduce(:*) / 7
      end
    end
  end
end
