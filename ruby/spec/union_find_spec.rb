require_relative "../lib/union_find"

# Union-Findのテスト
RSpec.describe UnionFind do
  let(:union_find) { UnionFind.new(10) }

  describe "same?のテスト" do
    context "同じ親の要素がある場合" do
      before do
        union_find.parents[2] = 1
      end
      it "same?で親が同じものを同じと判定できる" do
        expect(union_find.same?(1, 2)).to be_truthy
      end
    end
  end

  describe "unitのテスト" do
    context "親が違う場合にunitを使用した場合" do
      it "親が同じになる" do
        expect(union_find.same?(1, 10)).to be_falsy
        union_find.unite(1, 10)
        expect(union_find.same?(1, 10)).to be_truthy
      end
    end
  end
end
