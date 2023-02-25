require_relative "../lib/max_flow"

RSpec.describe MaxFlow do

  describe "add_edge" do
    context "各流量を追加した場合" do
      let (:max_flow) { MaxFlow.new(2) }
      before do
        max_flow.add_edge(1, 2, 5)
      end
      it "正しくgraphに反映されていること" do
        expect(max_flow.graph).to eq ([[], [MaxFlow::Edge.new(2, 0, 5)], [MaxFlow::Edge.new(1, 0, 0)]])
      end
    end
  end

  describe "max_flow" do
    context "最小流量が2の場合" do
      let (:max_flow) { MaxFlow.new(3) }
      before do
        max_flow.add_edge(1, 2, 5)
        max_flow.add_edge(2, 3, 2)
      end
      it "最小流量を求めることができる" do
        expect(max_flow.max_flow(1, 3)).to eq 2
      end
    end

    context "最小流量が0の場合" do
      let (:max_flow) { MaxFlow.new(3) }
      before do
        max_flow.add_edge(1, 2, 5)
        max_flow.add_edge(2, 3, 0)
      end
      it "最小流量0が得られる" do
        expect(max_flow.max_flow(1, 3)).to eq 0
      end
    end
  end


end
