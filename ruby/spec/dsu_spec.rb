require_relative "../lib/dsu"

# Union-Findのテスト
RSpec.describe DSU do
  let(:dsu) { DSU.new(11) }

  describe "rootのテスト" do
    context "初期値" do
      it "自分自身であること" do
        expect(dsu.root(7)).to eq 7
      end
    end

    context "連結された場合" do
      before do
        dsu.parent_or_size[7] = 0
        dsu.parent_or_size[0] = -2
      end
      it "親が返ること" do
        expect(dsu.root(7)).to eq 0
      end
    end
  end

  describe "same?のテスト" do
    context "同じ親の要素がある場合" do
      before do
        dsu.parent_or_size[2] = 1
        dsu.parent_or_size[1] = -2
      end
      it "same?で親が同じものを同じと判定できる" do
        expect(dsu.same?(1, 2)).to be_truthy
      end
    end
  end

  describe "uniteのテスト" do
    context "親が違う場合にuniteを使用した場合" do
      it "親が同じになる" do
        expect(dsu.same?(1, 10)).to be_falsy
        dsu.unite(1, 10)
        expect(dsu.same?(1, 10)).to be_truthy
      end
    end
  end

  describe "sizeのテスト" do
    context "初期のサイズ" do
      it "1であること" do
        expect(dsu.size(1)).to eq 1
      end
    end

    context "連結後のサイズ" do
      before do
        dsu.unite(0, 1)
        dsu.unite(0, 2)
        dsu.unite(0, 10)
      end
      it "親のサイズが正しいこと" do
        expect(dsu.size(0)).to eq 4
      end

      it "子のサイズが正しいこと" do
        expect(dsu.size(10)).to eq 4
      end
    end
  end

  describe "groupsとrootsのテスト" do
    before do
      dsu.unite(0, 1)
      dsu.unite(0, 2)
      dsu.unite(0, 3)
      dsu.unite(4, 5)
      dsu.unite(5, 6)
      dsu.unite(7, 8)
      dsu.unite(7, 9)
    end
    context "groups" do
      it "戻り値が正しいこと" do
        expect(dsu.groups).to eq [[0, [0, 1, 2, 3]], [4, [4, 5, 6]], [7, [7, 8, 9]], [10, [10]]].to_h
      end
    end

    context "roots" do
      it "戻り値が正しいこと" do
        expect(dsu.roots).to contain_exactly(0, 4, 7, 10)
      end
    end
  end
end
