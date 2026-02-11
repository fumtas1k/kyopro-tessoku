require "rspec-parameterized"

require_relative "../lib/fwt_sorted_multi_set"

# FwtSortedMultiSetのテスト
RSpec.describe FwtSortedMultiSet do
  let(:sorted) { [1, 3, 5, 7, 9] }
  let(:ss) { FwtSortedMultiSet.new(sorted) }

  describe "初期化テスト" do
    it "サイズが0であること" do
      expect(ss.size).to eq 0
    end

    it "空であること" do
      expect(ss.empty?).to be true
    end
  end

  describe "#add" do
    context "要素を追加した場合" do
      before do
        ss.add(3)
        ss.add(3)
        ss.add(5)
      end

      it "サイズが正しいこと" do
        expect(ss.size).to eq 3
      end

      it "要素数が正しいこと" do
        expect(ss.count(3)).to eq 2
        expect(ss.count(5)).to eq 1
        expect(ss.count(7)).to eq 0
      end
    end
  end

  describe "#delete" do
    before do
      ss.add(3)
      ss.add(3)
      ss.add(5)
    end

    context "存在する要素を削除した場合" do
      it "削除に成功すること" do
        expect(ss.delete(3)).to be true
        expect(ss.size).to eq 2
        expect(ss.count(3)).to eq 1
      end
    end

    context "存在しない要素を削除した場合" do
      it "削除に失敗すること" do
        expect(ss.delete(7)).to be false
        expect(ss.size).to eq 3
      end
    end
  end

  describe "#delete_at" do
    before do
      ss.add(1)
      ss.add(3)
      ss.add(3)
      ss.add(5)
    end

    context "有効な順位を指定した場合" do
      it "指定した順位の要素を削除して返すこと" do
        expect(ss.delete_at(2)).to eq 3
        expect(ss.size).to eq 3
        expect(ss.count(3)).to eq 1
      end
    end

    context "範囲外の順位を指定した場合" do
      it "nilを返すこと" do
        expect(ss.delete_at(0)).to be_nil
        expect(ss.delete_at(5)).to be_nil
      end
    end
  end

  describe "#delete_all" do
    before do
      ss.add(3)
      ss.add(3)
      ss.add(5)
    end

    it "指定した要素をすべて削除すること" do
      ss.delete_all(3)
      expect(ss.size).to eq 1
      expect(ss.count(3)).to eq 0
      expect(ss.count(5)).to eq 1
    end
  end

  describe "#lower_bound" do
    before do
      ss.add(1)
      ss.add(3)
      ss.add(5)
      ss.add(7)
    end

    where(:key, :expected) do
      [
        [0, 1],
        [1, 1],
        [2, 2],
        [5, 3],
        [10, 5]
      ]
    end

    with_them do
      it "正しい順位を返すこと" do
        expect(ss.lower_bound(key)).to eq expected
      end
    end
  end

  describe "#upper_bound" do
    before do
      ss.add(1)
      ss.add(3)
      ss.add(5)
      ss.add(7)
    end

    where(:key, :expected) do
      [
        [0, 1],
        [1, 2],
        [2, 2],
        [5, 4],
        [10, 5]
      ]
    end

    with_them do
      it "正しい順位を返すこと" do
        expect(ss.upper_bound(key)).to eq expected
      end
    end
  end

  describe "#count_range" do
    before do
      ss.add(1)
      ss.add(3)
      ss.add(3)
      ss.add(5)
      ss.add(7)
    end

    where(:left, :right, :expected) do
      [
        [1, 10, 5],
        [3, 7, 4],
        [3, 5, 3],
        [6, 8, 1],
        [10, 20, 0]
      ]
    end

    with_them do
      it "正しい要素数を返すこと" do
        expect(ss.count_range(left, right)).to eq expected
      end
    end
  end

  describe "#kth" do
    before do
      ss.add(1)
      ss.add(3)
      ss.add(3)
      ss.add(5)
    end

    where(:rank, :expected) do
      [
        [1, 1],
        [2, 3],
        [3, 3],
        [4, 5]
      ]
    end

    with_them do
      it "正しい要素を返すこと" do
        expect(ss.kth(rank)).to eq expected
      end
    end

    context "範囲外の順位を指定した場合" do
      it "nilを返すこと" do
        expect(ss.kth(0)).to be_nil
        expect(ss.kth(5)).to be_nil
      end
    end
  end

  describe "#min / #max" do
    before do
      ss.add(5)
      ss.add(1)
      ss.add(9)
    end

    it "最小値を返すこと" do
      expect(ss.min).to eq 1
    end

    it "最大値を返すこと" do
      expect(ss.max).to eq 9
    end

    context "空の場合" do
      let(:empty_ss) { FwtSortedMultiSet.new(sorted) }

      it "nilを返すこと" do
        expect(empty_ss.min).to be_nil
        expect(empty_ss.max).to be_nil
      end
    end
  end

  describe "#shift" do
    before do
      ss.add(1)
      ss.add(3)
      ss.add(5)
    end

    it "最小の要素を削除して返すこと" do
      expect(ss.shift).to eq 1
      expect(ss.size).to eq 2
      expect(ss.min).to eq 3
    end

    context "空の場合" do
      let(:empty_ss) { FwtSortedMultiSet.new(sorted) }

      it "nilを返すこと" do
        expect(empty_ss.shift).to be_nil
      end
    end
  end

  describe "#pop" do
    before do
      ss.add(1)
      ss.add(3)
      ss.add(5)
    end

    it "最大の要素を削除して返すこと" do
      expect(ss.pop).to eq 5
      expect(ss.size).to eq 2
      expect(ss.max).to eq 3
    end

    context "空の場合" do
      let(:empty_ss) { FwtSortedMultiSet.new(sorted) }

      it "nilを返すこと" do
        expect(empty_ss.pop).to be_nil
      end
    end
  end

  describe "#prev / #next" do
    before do
      ss.add(1)
      ss.add(5)
      ss.add(9)
    end

    describe "#prev" do
      where(:key, :expected) do
        [
          [0, nil],
          [1, 1],
          [3, 1],
          [5, 5],
          [7, 5],
          [10, 9]
        ]
      end

      with_them do
        it "正しい要素を返すこと" do
          expect(ss.prev(key)).to eq expected
        end
      end
    end

    describe "#next" do
      where(:key, :expected) do
        [
          [0, 1],
          [1, 1],
          [3, 5],
          [5, 5],
          [7, 9],
          [10, nil]
        ]
      end

      with_them do
        it "正しい要素を返すこと" do
          expect(ss.next(key)).to eq expected
        end
      end
    end
  end

  describe "#prev_strict / #next_strict" do
    before do
      ss.add(1)
      ss.add(5)
      ss.add(9)
    end

    describe "#prev_strict" do
      where(:key, :expected) do
        [
          [0, nil],
          [1, nil],
          [3, 1],
          [5, 1],
          [7, 5],
          [10, 9]
        ]
      end

      with_them do
        it "正しい要素を返すこと" do
          expect(ss.prev_strict(key)).to eq expected
        end
      end
    end

    describe "#next_strict" do
      where(:key, :expected) do
        [
          [0, 1],
          [1, 5],
          [3, 5],
          [5, 9],
          [9, nil],
          [10, nil]
        ]
      end

      with_them do
        it "正しい要素を返すこと" do
          expect(ss.next_strict(key)).to eq expected
        end
      end
    end
  end

  describe "#count / #[]" do
    before do
      ss.add(3)
      ss.add(3)
      ss.add(5)
    end

    it "正しい個数を返すこと" do
      expect(ss.count(3)).to eq 2
      expect(ss[3]).to eq 2
      expect(ss.count(5)).to eq 1
      expect(ss.count(7)).to eq 0
    end
  end

  describe "#include?" do
    before do
      ss.add(3)
      ss.add(5)
    end

    it "存在する要素に対してtrueを返すこと" do
      expect(ss.include?(3)).to be true
      expect(ss.include?(5)).to be true
    end

    it "存在しない要素に対してfalseを返すこと" do
      expect(ss.include?(1)).to be false
      expect(ss.include?(7)).to be false
    end
  end

  describe "#empty?" do
    it "空の場合trueを返すこと" do
      expect(ss.empty?).to be true
    end

    it "要素がある場合falseを返すこと" do
      ss.add(3)
      expect(ss.empty?).to be false
    end
  end

  describe "#each" do
    before do
      ss.add(3)
      ss.add(1)
      ss.add(3)
      ss.add(5)
    end

    it "昇順に要素を列挙すること" do
      result = []
      ss.each { |val| result << val }
      expect(result).to eq [1, 3, 3, 5]
    end

    context "ブロックなしの場合" do
      it "Enumeratorを返すこと" do
        expect(ss.each).to be_a Enumerator
      end
    end
  end

  describe "#to_a" do
    before do
      ss.add(3)
      ss.add(1)
      ss.add(3)
      ss.add(5)
    end

    it "昇順にソートされた配列を返すこと" do
      expect(ss.to_a).to eq [1, 3, 3, 5]
    end

    context "空の場合" do
      let(:empty_ss) { FwtSortedMultiSet.new(sorted) }

      it "空配列を返すこと" do
        expect(empty_ss.to_a).to eq []
      end
    end
  end

  describe "実践的な使用例" do
    it "example通りに動作すること" do
      test_ss = FwtSortedMultiSet.new([1, 3, 5, 7, 9])
      test_ss.add(3)
      test_ss.add(3)
      test_ss.add(5)

      expect(test_ss.kth(1)).to eq 3
      test_ss.delete_at(2) # 2番目の「3」を削除
      expect(test_ss.count_range(3, 7)).to eq 2
    end

    it "優先度付きキューとして使えること" do
      pq = FwtSortedMultiSet.new([1, 2, 3, 4, 5])
      pq.add(3)
      pq.add(1)
      pq.add(4)

      expect(pq.shift).to eq 1
      expect(pq.shift).to eq 3
      expect(pq.pop).to eq 4
    end
  end
end
