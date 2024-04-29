require_relative "../lib/scc"

# SCCのテスト
RSpec.describe SCC do
  let(:scc) { SCC.new(6) }
  let(:graph) {
    [
      [1, 4],
      [5, 2],
      [3, 0],
      [5, 5],
      [4, 1],
      [0, 3],
      [4, 2]
    ]
  }
  let(:edges) {
    [
      [3],
      [4],
      [],
      [0],
      [1, 2],
      [2, 5]
    ]
  }

  describe "add_edgeのテスト" do
    it "辺に追加されること" do
      scc.add_edge(1, 4)
      expect(scc.edges).to eq [
        [],
        [4],
        [],
        [],
        [],
        []
      ]
    end
  end

  describe "add_edgesのテスト" do
    it "辺に追加されること" do
      scc.add_edges(graph)
      expect(scc.edges).to eq edges
    end
  end

  describe "sccのテスト" do
    before do
      scc.add_edges(graph)
    end
    it "結果が正しいこと" do
      expect(scc.scc).to eq [
        [5],
        [1, 4],
        [2],
        [0, 3]
      ]
    end
  end
end
