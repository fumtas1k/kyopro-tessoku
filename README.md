# kyopro-tessoku
競技プログラミングの鉄則の解答

## 各論

| 問題(例) | アルゴリズム等 | ruby | java | kotlin |
| - | - | - | - | - |
| [A56](question/A56.txt) | ハッシュ | [ruby](ruby/A56.rb) | | |
| [A57](question/A57.txt) | ダブリング | [ruby](ruby/A57.rb) | | |
| [A58](question/A58.txt) | セグメント木(RMQ) | [ruby](ruby/A58.rb) | | |
| [A59](question/A59.txt) | セグメント木(RSQ) | [ruby](ruby/A59.rb) | | |
| [A64](question/A64.txt) | ダイクストラ法 | [ruby](ruby/A64.rb) | | |
| [A67](question/A67.txt) | 最小全域木, クラスカル法 | [ruby](ruby/A67.rb) | | |
| [A68](question/A68.txt) | 最大流量, Ford-Fulkerson法 | [ruby](ruby/A68.rb) | | [kotlin](src/main/kotlin/ktln/A68.kt) |
| [A69](question/A69.txt) | 二部マッチング, Ford-Fulkerson法 | [ruby]
(ruby/A69.rb) | | |
## ライブラリ

| アルゴリズム名 | クラス名 | ruby | java | kotlin |
| - | - | - | - | - |
| セグメント木 | SegmentTree | [ruby](ruby/lib/segment_tree.rb) | | [kotlin再帰](src/main/kotlin/ktln/lib/SegmentTreeR.kt), [kotlin非再帰](src/main/kotlin/ktln/lib/SegmentTreeW.kt) |
| 素集合データ構造 | UnionFind | [ruby](ruby/lib/union_find.rb) | [java](src/main/java/jv/lib/UnionFind.java) | [kotlin](src/main/kotlin/ktln/lib/UnionFind.kt) |
| ヒープ | MinHeap | [ruby](ruby/lib/min_heap.rb) | | |
| 優先度付キュー | PriorityQueue | [ruby](ruby/lib/priority_queue.rb) | | |
| 最大流量 | MaxFlow | [ruby](ruby/lib/max_flow.rb) | | [kotlin](src/main/kotlin/ktln/lib/MaxFlow.kt) |
