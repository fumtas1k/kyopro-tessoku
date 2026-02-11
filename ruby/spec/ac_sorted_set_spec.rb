require "rspec-parameterized"

require_relative "../lib/ac_sorted_set"

# AcSortedMultiSetのテスト
RSpec.describe AcSortedMultiSet do
  let(:ms) { AcSortedMultiSet.new }

  describe "初期化テスト" do
    context "引数なしの場合" do
      it "サイズが0であること" do
        expect(ms.size).to eq 0
      end

      it "空であること" do
        expect(ms.empty?).to be true
      end
    end

    context "配列で初期化する場合" do
      let(:ms_with_array) { AcSortedMultiSet.new([5, 3, 1, 3, 7]) }

      it "サイズが正しいこと" do
        expect(ms_with_array.size).to eq 5
      end

      it "ソートされていること" do
        expect(ms_with_array.to_a).to eq [1, 3, 3, 5, 7]
      end
    end
  end

  describe "#add / #<<" do
    it "要素を追加できること" do
      ms.add(3)
      ms.add(1)
      ms << 5

      expect(ms.size).to eq 3
      expect(ms.to_a).to eq [1, 3, 5]
    end

    it "重複を許すこと" do
      ms.add(3)
      ms.add(3)
      ms.add(3)

      expect(ms.size).to eq 3
      expect(ms.count(3)).to eq 3
    end

    it "大量の要素を追加できること" do
      100.times { |i| ms.add(i) }
      expect(ms.size).to eq 100
      expect(ms.min).to eq 0
      expect(ms.max).to eq 99
    end
  end

  describe "#delete" do
    before do
      ms.add(3)
      ms.add(3)
      ms.add(5)
    end

    context "存在する要素を削除した場合" do
      it "削除に成功すること" do
        expect(ms.delete(3)).to be true
        expect(ms.size).to eq 2
        expect(ms.count(3)).to eq 1
      end
    end

    context "存在しない要素を削除した場合" do
      it "削除に失敗すること" do
        expect(ms.delete(7)).to be false
        expect(ms.size).to eq 3
      end
    end
  end

  describe "#delete_all" do
    before do
      ms.add(3)
      ms.add(3)
      ms.add(3)
      ms.add(5)
    end

    it "指定した要素をすべて削除すること" do
      count = ms.delete_all(3)
      expect(count).to eq 3
      expect(ms.size).to eq 1
      expect(ms.count(3)).to eq 0
    end
  end

  describe "#include? / #member?" do
    before do
      ms.add(3)
      ms.add(5)
      ms.add(7)
    end

    it "存在する要素に対してtrueを返すこと" do
      expect(ms.include?(3)).to be true
      expect(ms.member?(5)).to be true
    end

    it "存在しない要素に対してfalseを返すこと" do
      expect(ms.include?(1)).to be false
      expect(ms.member?(10)).to be false
    end
  end

  describe "#lower_bound" do
    before do
      ms.add(1)
      ms.add(3)
      ms.add(5)
      ms.add(7)
    end

    where(:value, :expected) do
      [
        [0, 1],
        [1, 1],
        [2, 3],
        [5, 5],
        [6, 7],
        [10, nil]
      ]
    end

    with_them do
      it "正しい値を返すこと" do
        expect(ms.lower_bound(value)).to eq expected
      end
    end
  end

  describe "#upper_bound" do
    before do
      ms.add(1)
      ms.add(3)
      ms.add(5)
      ms.add(7)
    end

    where(:value, :expected) do
      [
        [0, 1],
        [1, 3],
        [2, 3],
        [5, 7],
        [7, nil],
        [10, nil]
      ]
    end

    with_them do
      it "正しい値を返すこと" do
        expect(ms.upper_bound(value)).to eq expected
      end
    end
  end

  describe "#reverse_lower_bound" do
    before do
      ms.add(1)
      ms.add(3)
      ms.add(5)
      ms.add(7)
    end

    where(:value, :expected) do
      [
        [0, nil],
        [1, 1],
        [2, 1],
        [5, 5],
        [6, 5],
        [10, 7]
      ]
    end

    with_them do
      it "正しい値を返すこと" do
        expect(ms.reverse_lower_bound(value)).to eq expected
      end
    end
  end

  describe "#prev" do
    before do
      ms.add(1)
      ms.add(3)
      ms.add(5)
      ms.add(7)
    end

    where(:value, :expected) do
      [
        [0, nil],
        [1, nil],
        [2, 1],
        [5, 3],
        [6, 5],
        [10, 7]
      ]
    end

    with_them do
      it "正しい値を返すこと" do
        expect(ms.prev(value)).to eq expected
      end
    end
  end

  describe "#next_val" do
    before do
      ms.add(1)
      ms.add(3)
      ms.add(5)
      ms.add(7)
    end

    it "upper_boundと同じ動作をすること" do
      expect(ms.next_val(3)).to eq ms.upper_bound(3)
      expect(ms.next_val(5)).to eq ms.upper_bound(5)
    end
  end

  describe "#kth / #[]" do
    before do
      ms.add(1)
      ms.add(3)
      ms.add(3)
      ms.add(5)
      ms.add(7)
    end

    where(:index, :expected) do
      [
        [0, 1],
        [1, 3],
        [2, 3],
        [3, 5],
        [4, 7]
      ]
    end

    with_them do
      it "正しい要素を返すこと" do
        expect(ms.kth(index)).to eq expected
        expect(ms[index]).to eq expected
      end
    end

    context "範囲外のインデックスの場合" do
      it "nilを返すこと" do
        expect(ms.kth(-1)).to be_nil
        expect(ms.kth(5)).to be_nil
      end
    end
  end

  describe "#count_less" do
    before do
      ms.add(1)
      ms.add(3)
      ms.add(5)
      ms.add(7)
    end

    where(:value, :expected) do
      [
        [0, 0],
        [1, 0],
        [2, 1],
        [5, 2],
        [10, 4]
      ]
    end

    with_them do
      it "正しい個数を返すこと" do
        expect(ms.count_less(value)).to eq expected
      end
    end
  end

  describe "#count_le" do
    before do
      ms.add(1)
      ms.add(3)
      ms.add(5)
      ms.add(7)
    end

    where(:value, :expected) do
      [
        [0, 0],
        [1, 1],
        [2, 1],
        [5, 3],
        [10, 4]
      ]
    end

    with_them do
      it "正しい個数を返すこと" do
        expect(ms.count_le(value)).to eq expected
      end
    end
  end

  describe "#count_range" do
    before do
      ms.add(1)
      ms.add(3)
      ms.add(5)
      ms.add(7)
      ms.add(9)
    end

    where(:left, :right, :expected) do
      [
        [1, 10, 5],
        [3, 7, 3],
        [5, 5, 1],
        [6, 8, 1],
        [10, 20, 0]
      ]
    end

    with_them do
      it "正しい要素数を返すこと" do
        expect(ms.count_range(left, right)).to eq expected
      end
    end
  end

  describe "#count" do
    before do
      ms.add(3)
      ms.add(3)
      ms.add(5)
    end

    it "正しい個数を返すこと" do
      expect(ms.count(3)).to eq 2
      expect(ms.count(5)).to eq 1
      expect(ms.count(7)).to eq 0
    end
  end

  describe "#index" do
    before do
      ms.add(1)
      ms.add(3)
      ms.add(5)
    end

    it "存在する要素のインデックスを返すこと" do
      expect(ms.index(1)).to eq 0
      expect(ms.index(3)).to eq 1
      expect(ms.index(5)).to eq 2
    end

    it "存在しない要素に対してnilを返すこと" do
      expect(ms.index(2)).to be_nil
      expect(ms.index(10)).to be_nil
    end
  end

  describe "#min / #max" do
    before do
      ms.add(5)
      ms.add(1)
      ms.add(9)
      ms.add(3)
    end

    it "最小値を返すこと" do
      expect(ms.min).to eq 1
    end

    it "最大値を返すこと" do
      expect(ms.max).to eq 9
    end

    context "空の場合" do
      let(:empty_ms) { AcSortedMultiSet.new }

      it "nilを返すこと" do
        expect(empty_ms.min).to be_nil
        expect(empty_ms.max).to be_nil
      end
    end
  end

  describe "#shift" do
    before do
      ms.add(1)
      ms.add(3)
      ms.add(5)
    end

    it "最小の要素を削除して返すこと" do
      expect(ms.shift).to eq 1
      expect(ms.size).to eq 2
      expect(ms.min).to eq 3
    end

    context "空の場合" do
      let(:empty_ms) { AcSortedMultiSet.new }

      it "nilを返すこと" do
        expect(empty_ms.shift).to be_nil
      end
    end
  end

  describe "#pop" do
    before do
      ms.add(1)
      ms.add(3)
      ms.add(5)
    end

    it "最大の要素を削除して返すこと" do
      expect(ms.pop).to eq 5
      expect(ms.size).to eq 2
      expect(ms.max).to eq 3
    end

    context "空の場合" do
      let(:empty_ms) { AcSortedMultiSet.new }

      it "nilを返すこと" do
        expect(empty_ms.pop).to be_nil
      end
    end
  end

  describe "#each" do
    before do
      ms.add(3)
      ms.add(1)
      ms.add(5)
    end

    it "昇順に要素を列挙すること" do
      result = []
      ms.each { |val| result << val }
      expect(result).to eq [1, 3, 5]
    end

    context "ブロックなしの場合" do
      it "Enumeratorを返すこと" do
        expect(ms.each).to be_a Enumerator
      end
    end
  end

  describe "#reverse_each" do
    before do
      ms.add(3)
      ms.add(1)
      ms.add(5)
    end

    it "降順に要素を列挙すること" do
      result = []
      ms.reverse_each { |val| result << val }
      expect(result).to eq [5, 3, 1]
    end

    context "ブロックなしの場合" do
      it "Enumeratorを返すこと" do
        expect(ms.reverse_each).to be_a Enumerator
      end
    end
  end

  describe "#to_a" do
    before do
      ms.add(3)
      ms.add(1)
      ms.add(3)
      ms.add(5)
    end

    it "昇順にソートされた配列を返すこと" do
      expect(ms.to_a).to eq [1, 3, 3, 5]
    end

    context "空の場合" do
      let(:empty_ms) { AcSortedMultiSet.new }

      it "空配列を返すこと" do
        expect(empty_ms.to_a).to eq []
      end
    end
  end

  describe "大規模データでのテスト" do
    it "大量の要素を正しく処理できること" do
      1000.times { |i| ms.add(i % 100) }
      expect(ms.size).to eq 1000
      expect(ms.min).to eq 0
      expect(ms.max).to eq 99
      expect(ms.count(50)).to eq 10
    end
  end
end

# AcSortedSetのテスト
RSpec.describe AcSortedSet do
  let(:ss) { AcSortedSet.new }

  describe "初期化テスト" do
    context "引数なしの場合" do
      it "サイズが0であること" do
        expect(ss.size).to eq 0
      end

      it "空であること" do
        expect(ss.empty?).to be true
      end
    end

    context "配列で初期化する場合" do
      let(:ss_with_array) { AcSortedSet.new([5, 3, 1, 3, 7]) }

      it "サイズが正しいこと（重複除外）" do
        expect(ss_with_array.size).to eq 4
      end

      it "ソートされていること" do
        expect(ss_with_array.to_a).to eq [1, 3, 5, 7]
      end
    end
  end

  describe "#add / #<<" do
    it "要素を追加できること" do
      expect(ss.add(3)).to be true
      expect(ss.add(1)).to be true
      expect(ss << 5).to be true

      expect(ss.size).to eq 3
      expect(ss.to_a).to eq [1, 3, 5]
    end

    it "重複を許さないこと" do
      expect(ss.add(3)).to be true
      expect(ss.add(3)).to be false
      expect(ss.add(3)).to be false

      expect(ss.size).to eq 1
    end
  end

  describe "#delete" do
    before do
      ss.add(3)
      ss.add(5)
    end

    context "存在する要素を削除した場合" do
      it "削除に成功すること" do
        expect(ss.delete(3)).to be true
        expect(ss.size).to eq 1
      end
    end

    context "存在しない要素を削除した場合" do
      it "削除に失敗すること" do
        expect(ss.delete(7)).to be false
        expect(ss.size).to eq 2
      end
    end
  end

  describe "#include? / #member?" do
    before do
      ss.add(3)
      ss.add(5)
      ss.add(7)
    end

    it "存在する要素に対してtrueを返すこと" do
      expect(ss.include?(3)).to be true
      expect(ss.member?(5)).to be true
    end

    it "存在しない要素に対してfalseを返すこと" do
      expect(ss.include?(1)).to be false
      expect(ss.member?(10)).to be false
    end
  end

  describe "bound系メソッド" do
    before do
      ss.add(1)
      ss.add(3)
      ss.add(5)
      ss.add(7)
    end

    it "lower_boundが正しく動作すること" do
      expect(ss.lower_bound(2)).to eq 3
      expect(ss.lower_bound(5)).to eq 5
    end

    it "upper_boundが正しく動作すること" do
      expect(ss.upper_bound(3)).to eq 5
      expect(ss.upper_bound(7)).to be_nil
    end

    it "reverse_lower_boundが正しく動作すること" do
      expect(ss.reverse_lower_bound(6)).to eq 5
      expect(ss.reverse_lower_bound(1)).to eq 1
    end

    it "prevが正しく動作すること" do
      expect(ss.prev(5)).to eq 3
      expect(ss.prev(1)).to be_nil
    end

    it "next_valが正しく動作すること" do
      expect(ss.next_val(3)).to eq 5
      expect(ss.next_val(7)).to be_nil
    end
  end

  describe "#kth / #[]" do
    before do
      ss.add(1)
      ss.add(3)
      ss.add(5)
      ss.add(7)
    end

    where(:index, :expected) do
      [
        [0, 1],
        [1, 3],
        [2, 5],
        [3, 7]
      ]
    end

    with_them do
      it "正しい要素を返すこと" do
        expect(ss.kth(index)).to eq expected
        expect(ss[index]).to eq expected
      end
    end
  end

  describe "#min / #max" do
    before do
      ss.add(5)
      ss.add(1)
      ss.add(9)
      ss.add(3)
    end

    it "最小値を返すこと" do
      expect(ss.min).to eq 1
    end

    it "最大値を返すこと" do
      expect(ss.max).to eq 9
    end
  end

  describe "#shift / #pop" do
    before do
      ss.add(1)
      ss.add(3)
      ss.add(5)
    end

    it "shiftが正しく動作すること" do
      expect(ss.shift).to eq 1
      expect(ss.size).to eq 2
    end

    it "popが正しく動作すること" do
      expect(ss.pop).to eq 5
      expect(ss.size).to eq 2
    end
  end

  describe "#each / #reverse_each" do
    before do
      ss.add(3)
      ss.add(1)
      ss.add(5)
    end

    it "eachが昇順に列挙すること" do
      result = []
      ss.each { |val| result << val }
      expect(result).to eq [1, 3, 5]
    end

    it "reverse_eachが降順に列挙すること" do
      result = []
      ss.reverse_each { |val| result << val }
      expect(result).to eq [5, 3, 1]
    end
  end

  describe "#to_a" do
    before do
      ss.add(3)
      ss.add(1)
      ss.add(5)
    end

    it "昇順にソートされた配列を返すこと" do
      expect(ss.to_a).to eq [1, 3, 5]
    end
  end

  describe "AcSortedMultiSetとの比較" do
    it "重複の扱いが異なること" do
      ms = AcSortedMultiSet.new([1, 2, 2, 3])
      set = AcSortedSet.new([1, 2, 2, 3])

      expect(ms.size).to eq 4
      expect(set.size).to eq 3

      expect(ms.to_a).to eq [1, 2, 2, 3]
      expect(set.to_a).to eq [1, 2, 3]
    end
  end
end
