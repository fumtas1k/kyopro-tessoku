require_relative "../lib/segment_tree_w"

# セグメント木のテスト
RSpec.describe SegmentTreeW do
  describe "加算" do
    let(:arr) { [3, 7, 5, 2, 1, 4, 10, 8, 9, 6] }
    let(:segment_tree) { SegmentTreeW.new(arr, 0){|a, b| [a, b].sum} }

    context "要素数が10個の配列の場合" do
      it "葉の数は16" do
        expect(segment_tree.leaf_size).to eq 16
      end
    end

    context "prodで範囲を指定した場合" do
      it "その範囲の合計が得られる" do
        expect(segment_tree.prod(0, 5)).to eq arr[0, 5].sum
      end
    end

    context "要素の値を更新した場合" do
      before do
        segment_tree.set(1, 0)
      end
      it "prodで更新後の合計が得られる" do
        expect(segment_tree.prod(0, 5)).to eq arr[0, 5].sum - 7
      end
    end

    context "max_right" do
      it "条件を満たす最大のindex+1が得られる" do
        expect(segment_tree.max_right(0) { _1 <= 17 }).to eq 4
      end
    end

    context "min_left" do
      it "条件を満たす最小のindexが得られる" do
        expect(segment_tree.min_left(10) { _1 <= 23 }).to eq 7
      end
    end
  end

  describe "最大値" do
    let(:arr) { [3, 7, 5, 2, 1, 4, 10, 8, 9, 6] }
    let(:segment_tree) { SegmentTreeW.new(arr, 1){|a, b| [a, b].max} }

    context "prodで範囲を指定した場合" do
      it "その範囲の最大値が得られる" do
        expect(segment_tree.prod(0, 5)).to eq 7
      end
    end

    context "要素の値を更新した場合" do
      before do
        segment_tree.set(1, 1_000_000)
      end
      it "prodで指定した範囲の更新後の最大値が得られる" do
        expect(segment_tree.prod(0, 5)).to eq 1_000_000
      end
    end

    context "max_right" do
      it "条件を満たす最大のindex+1が得られる" do
        expect(segment_tree.max_right(0) { _1 < 10 }).to eq 6
      end
    end

    context "min_left" do
      it "条件を満たす最小のindexが得られる" do
        expect(segment_tree.min_left(10) { _1 < 10 }).to eq 7
      end
    end
  end
end
