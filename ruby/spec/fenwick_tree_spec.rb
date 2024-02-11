require_relative "../lib/fenwick_tree"

# FenwickTreeのテスト
RSpec.describe FenwickTree do
  let(:init_result) { [0, 0, 1, 2, 6, 4, 9, 6, 28, 8, 17] }
  describe "初期化テスト" do
    context "数値で初期化する場合" do
      it "データが正しいこと" do
        ft_int = FenwickTree.new(10)
        expect(ft_int.data).to eq [0] * 11
      end
    end
    context "配列で初期化した場合" do
      it "データが正しいこと" do
        ft_arr = FenwickTree.new([*0 ... 10])
        expect(ft_arr.data).to eq init_result
      end
    end
  end

  describe "加算のテスト" do
    context "数値で初期化後加算した場合" do
      it "データが正しいこと" do
        ft_int = FenwickTree.new(10)
        10.times { ft_int.add(_1, _1) }
        expect(ft_int.data).to eq init_result
      end
    end
  end

  describe "合計のテスト" do
    it "合計が正しいこと" do
      ft_arr = FenwickTree.new([*0 ... 10])
      expect(ft_arr.sum(10)).to eq [*0 ... 10].sum
      expect(ft_arr.sum(5)).to eq [*0 ... 5].sum
      expect(ft_arr.sum(5, 10)).to eq [*5 ... 10].sum
      10.times do |i|
        expect(ft_arr.sum(i, i + 1)).to eq i
      end
    end
  end

  describe "範囲加算のテスト" do
    let(:ft) { FenwickTree.new(11) }
    let(:ans) { [1, 1, 4, 3, 3, 3, 3, 5, 5, 2, 0] }
    before do
      ft.add_by_range(0, 3, 1)
      ft.add_by_range(7, 10, 2)
      ft.add_by_range(2, 9, 3)
    end
    it "値が正しいこと" do
      10.times do |i|
        expect(ft.sum(i + 1)).to eq ans[i]
      end
    end
  end
end
