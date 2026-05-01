require_relative "../lib/lca"

# LCA（最小共通祖先）のテスト
RSpec.describe LCA do
  describe "#initialize" do
    let(:lca) { LCA.new(5, 0) }

    it "頂点数が設定されること" do
      expect(lca.size).to eq 5
    end

    it "根が設定されること" do
      expect(lca.root).to eq 0
    end

    it "ダブリングの段数が n.bit_length であること" do
      expect(lca.bit).to eq 5.bit_length
    end

    it "辺が空であること" do
      expect(lca.edges).to eq Array.new(5) { [] }
    end
  end

  describe "#add_edge" do
    let(:lca) { LCA.new(3, 0) }

    it "両方向に辺が追加されること" do
      lca.add_edge(0, 1)
      expect(lca.edges[0]).to eq [1]
      expect(lca.edges[1]).to eq [0]
    end
  end

  describe "#build" do
    #     0
    #    / \
    #   1   2
    #  / \
    # 3   4
    let(:lca) {
      lca = LCA.new(5, 0)
      lca.add_edge(0, 1)
      lca.add_edge(0, 2)
      lca.add_edge(1, 3)
      lca.add_edge(1, 4)
      lca.build
      lca
    }

    it "各頂点の深さが正しく計算されること" do
      expect(lca.depth).to eq [0, 1, 1, 2, 2]
    end

    it "各頂点の親 (parents[0]) が正しく設定されること" do
      # 根の親は自分自身
      expect(lca.parents[0][0]).to eq 0
      expect(lca.parents[0][1]).to eq 0
      expect(lca.parents[0][2]).to eq 0
      expect(lca.parents[0][3]).to eq 1
      expect(lca.parents[0][4]).to eq 1
    end

    it "ダブリングテーブルが正しく構築されること" do
      # 2 個上の祖先 (parents[1]): いずれも根 (= 0)
      5.times { |v| expect(lca.parents[1][v]).to eq 0 }
    end
  end

  describe "#get" do
    context "ビルド前に呼ばれた場合" do
      let(:lca) { LCA.new(3, 0) }

      it "例外が発生すること" do
        lca.add_edge(0, 1)
        lca.add_edge(0, 2)
        expect { lca.get(1, 2) }.to raise_error(RuntimeError, /buildされていません/)
      end
    end

    context "二分木の場合" do
      #         0
      #       /   \
      #      1     2
      #     / \   / \
      #    3   4 5   6
      let(:lca) {
        lca = LCA.new(7, 0)
        [[0, 1], [0, 2], [1, 3], [1, 4], [2, 5], [2, 6]].each { lca.add_edge(*_1) }
        lca.build
        lca
      }

      it "兄弟ノードのLCAが親であること" do
        expect(lca.get(3, 4)).to eq 1
        expect(lca.get(5, 6)).to eq 2
      end

      it "異なる部分木のノードのLCAが根であること" do
        expect(lca.get(3, 6)).to eq 0
        expect(lca.get(4, 5)).to eq 0
      end

      it "祖先と子孫の関係ではLCAが祖先側であること" do
        expect(lca.get(1, 3)).to eq 1
        expect(lca.get(0, 6)).to eq 0
      end

      it "同じ頂点を指定した場合はその頂点を返すこと" do
        expect(lca.get(3, 3)).to eq 3
        expect(lca.get(0, 0)).to eq 0
      end

      it "頂点の順序を入れ替えても結果が同じであること" do
        expect(lca.get(3, 6)).to eq lca.get(6, 3)
        expect(lca.get(1, 5)).to eq lca.get(5, 1)
      end
    end

    context "パスグラフ (鎖) の場合" do
      # 0 - 1 - 2 - 3 - 4
      let(:lca) {
        lca = LCA.new(5, 0)
        4.times { |i| lca.add_edge(i, i + 1) }
        lca.build
        lca
      }

      it "深さが連続していること" do
        expect(lca.depth).to eq [0, 1, 2, 3, 4]
      end

      it "浅い側の頂点がLCAであること" do
        expect(lca.get(2, 4)).to eq 2
        expect(lca.get(0, 4)).to eq 0
        expect(lca.get(1, 3)).to eq 1
      end
    end

    context "根が 0 でない場合" do
      #         3
      #       /   \
      #      1     2
      #     /
      #    0
      let(:lca) {
        lca = LCA.new(4, 3)
        [[3, 1], [3, 2], [1, 0]].each { lca.add_edge(*_1) }
        lca.build
        lca
      }

      it "指定した頂点が根として扱われること" do
        expect(lca.depth[3]).to eq 0
        expect(lca.parents[0][3]).to eq 3
      end

      it "LCAが正しく求まること" do
        expect(lca.get(0, 2)).to eq 3
        expect(lca.get(0, 1)).to eq 1
      end
    end

    context "深い木の場合 (再帰スタックオーバーフロー回避の確認)" do
      # 0 - 1 - 2 - ... - (n-1) の長いパス
      let(:n) { 20_000 }
      let(:lca) {
        lca = LCA.new(n, 0)
        (n - 1).times { |i| lca.add_edge(i, i + 1) }
        lca.build
        lca
      }

      it "深い木でも build できること" do
        expect(lca.depth.last).to eq n - 1
      end

      it "深い木でも LCA を求められること" do
        expect(lca.get(n - 1, n / 2)).to eq n / 2
        expect(lca.get(0, n - 1)).to eq 0
      end
    end
  end

  describe "build と add_edge の連携" do
    let(:lca) {
      lca = LCA.new(4, 0)
      lca.add_edge(0, 1)
      lca.add_edge(1, 2)
      lca.build
      lca
    }

    it "build 後に add_edge すると get が例外を投げること" do
      lca.add_edge(2, 3)
      expect { lca.get(0, 3) }.to raise_error(RuntimeError, /buildされていません/)
    end

    it "再 build すれば get が再び使えること" do
      lca.add_edge(2, 3)
      lca.build
      expect(lca.get(0, 3)).to eq 0
      expect(lca.get(2, 3)).to eq 2
    end
  end
end
