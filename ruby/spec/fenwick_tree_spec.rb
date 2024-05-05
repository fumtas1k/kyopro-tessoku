require "rspec-parameterized"

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
    let(:ft_arr) { FenwickTree.new([*0 ... 10]) }
    context "指定" do
      where(:l, :r, :expected) do
        [
          [10, nil, 45],
          [5, nil, 10],
          [5, 10, 35]
        ]
      end
      with_them do
        it "合計が正しいこと" do
          expect(ft_arr.sum(l, r)).to eq expected
        end
      end
    end
    context "１つずつ" do
      it "合計が正しいこと" do
        10.times { expect(ft_arr.sum(_1, _1 + 1)).to eq _1 }
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
