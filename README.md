# kyopro-tessoku
競技プログラミングの鉄則の解答

## 各論

| 問題(例) | アルゴリズム等 | ruby | java | kotlin |
| - | - | - | - | - |
| [A13](question/A13.txt) | しゃくとり法 | [ruby](ruby/A13.rb) | | |
| [A16](question/A16.txt) | 動的計画法 | [ruby](ruby/A16.rb) | | |
| [A17](question/A17.txt) | 動的計画法, DP復元 | [ruby](ruby/A17.rb) | | |
| [A20](question/A20.txt) | 動的計画法, 最長共通部分列 | [ruby](ruby/A20.rb) | | |
| [A21](question/A21.txt) | 動的計画法, 区間DP | [ruby](ruby/A21.rb) | | |
| [A23](question/A23.txt) | 動的計画法, bitDP | [ruby](ruby/A23.rb) | | |
| [A24](question/A24.txt) | 動的計画法, 二分探索法, 最長増加部分列, LIS | [ruby](ruby/A24.rb) | | |
| [A25](question/A25.txt) | 動的計画法, Number of Routes | [ruby](ruby/A25.rb) | | |
| [A26](question/A26-01.txt) | 素数判定 | [ruby1](ruby/A26-01.rb), [ruby2](ruby/A26-02.rb) | | |
| [A29](question/A29.txt) | 累乗 | [ruby](ruby/A29.rb) | | |
| [A30](question/A30.txt) | フェルマーの小定理 | [ruby](ruby/A30.rb) | | |
| [A33](question/A33.txt) | ニム | [ruby](ruby/A33.rb) | | |
| [A38](question/A38.txt) | 上限値 | [ruby](ruby/A38.rb) | | |
| [A39](question/A39.txt) | 貪欲法 | [ruby](ruby/A39.rb) | | |
| [A40](question/A40.txt) | 個数を考える | [ruby](ruby/A40.rb) | | |
| [A41](question/A41.txt) | 後ろから考える | [ruby](ruby/A41.rb) | | |
| [A46](question/A46.txt) | Heuristic, 貪欲法 | [ruby](ruby/A46.rb) | | |
| [A47](question/A47.txt) | Heuristic, 局所探索法 | [ruby](ruby/A47.rb) | | |
| [A48](question/A48.txt) | Heuristic, 焼きなまし法 | [ruby](ruby/A48.rb) | | |
| [A49](question/A49.txt) | Heuristic, ビームサーチ | [ruby](ruby/A49.rb) | | |
| [A56](question/A56.txt) | ハッシュ | [ruby](ruby/A56.rb) | | |
| [A57](question/A57.txt) | ダブリング | [ruby](ruby/A57.rb) | | |
| [A58](question/A58.txt) | セグメント木(RMQ) | [ruby](ruby/A58.rb) | | |
| [A59](question/A59.txt) | セグメント木(RSQ) | [ruby](ruby/A59.rb) | | |
| [A62](question/A62.txt) | 深さ優先探索(DFS) | [ruby](ruby/A62.rb) | | |
| [A63](question/A63.txt) | 幅優先探索(BFS) | [ruby](ruby/A63.rb) | | |
| [A64](question/A64.txt) | ダイクストラ法 | [ruby](ruby/A64.rb) | | |
| [A65](question/A65-1.txt) | 木に対する動的計画法, 深さ優先探索(DFS) | [ruby1](ruby/A65-01.rb), [ruby2](ruby/A65-02.rb) | | |
| [A67](question/A67.txt) | 最小全域木, クラスカル法 | [ruby](ruby/A67.rb) | | |
| [A68](question/A68.txt) | 最大流量, Ford-Fulkerson法 | [ruby](ruby/A68.rb) | | [kotlin](src/main/kotlin/ktln/A68.kt) |
| [A69](question/A69.txt) | 二部マッチング, Ford-Fulkerson法 | [ruby](ruby/A69.rb) | | |
| [A72](question/A72.txt) | bit全探索 | [ruby](ruby/A72.rb) | | |
| [A73](question/A73.txt) | ダイクストラ法, わずかなボーナス | [ruby](ruby/A73.rb) | | |
| [A74](question/A74.txt) | 分解して考える | [ruby](ruby/A74.rb) | | |
| [A75](question/A75.txt) | 貪欲法, 動的計画法 | [ruby](ruby/A75.rb) | | |

## ライブラリ

| アルゴリズム名 | クラス名 | ruby | java | kotlin |
| - | - | - | - | - |
| セグメント木 | SegmentTree | [ruby](ruby/lib/segment_tree.rb) | | [kotlin再帰](src/main/kotlin/ktln/lib/SegmentTreeR.kt), [kotlin非再帰](src/main/kotlin/ktln/lib/SegmentTreeW.kt) |
| 素集合データ構造 | UnionFind | [ruby](ruby/lib/union_find.rb) | [java](src/main/java/jv/lib/UnionFind.java) | [kotlin](src/main/kotlin/ktln/lib/UnionFind.kt) |
| ヒープ | MinHeap | [ruby](ruby/lib/min_heap.rb) | | |
| 優先度付キュー | PriorityQueue | [ruby](ruby/lib/priority_queue.rb) | | |
| 最大流量 | MaxFlow | [ruby](ruby/lib/max_flow.rb) | | [kotlin](src/main/kotlin/ktln/lib/MaxFlow.kt) |
