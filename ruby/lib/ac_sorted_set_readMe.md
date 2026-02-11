# AcSortedMultiSet / AcSortedSet for Ruby 競技プログラミング

AtCoder等の競技プログラミングで使える **pure Ruby** のソート済み多重集合 / 集合。
C++の `std::multiset` + `__gnu_pbds::tree` に相当する機能を提供します。

## 使い方

提出コードの先頭に `ac_sorted_set.rb` の内容をコピペして使います（101行）。

## API リファレンス

### AcSortedMultiSet（重複許可）

```ruby
ms = AcSortedMultiSet.new           # 空で初期化
ms = AcSortedMultiSet.new([3,1,4])  # 配列から初期化 → [1, 3, 4]

# 追加・削除
ms.add(5)          # ms << 5 でも可
ms.delete(5)       # 1つ削除。なければfalse
ms.delete_all(5)   # 全て削除。削除した個数を返す

# 検索
ms.include?(5)     # 存在判定
ms.lower_bound(4)  # 4以上の最小値（なければnil）  ← C++の lower_bound
ms.upper_bound(4)  # 4より大きい最小値（なければnil）← C++の upper_bound
ms.reverse_lower_bound(4)  # 4以下の最大値（なければnil）
ms.prev(4)         # 4より小さい最大値（なければnil）

# 順序統計量 (Order Statistics) ← これが最大の特徴
ms.kth(k)          # k番目(0-indexed)の要素。ms[k]でも可
ms.count_less(v)   # v未満の要素数
ms.count_le(v)     # v以下の要素数
ms.count_range(l, h)  # l以上h以下の要素数
ms.count(v)        # vの個数
ms.index(v)        # vの最初の出現位置（なければnil）

# 最小・最大
ms.min             # 最小値
ms.max             # 最大値
ms.shift           # 最小値を削除して返す
ms.pop             # 最大値を削除して返す

# その他
ms.size            # 要素数
ms.empty?          # 空か
ms.each { |v| }   # 昇順イテレーション
ms.reverse_each { |v| }  # 降順イテレーション
ms.to_a            # 配列に変換
```

### AcSortedSet（重複なし）

AcSortedMultiSetと同じAPIですが、`add`は重複時に`false`を返します。

```ruby
ss = AcSortedSet.new
ss.add(5)   #=> true  (self)
ss.add(5)   #=> false (既に存在)
ss.to_a     #=> [5]
```

## 典型的な使用パターン

### 1. 中央値クエリ（要素を追加しながら中央値を取得）
```ruby
ms = AcSortedMultiSet.new
values.each do |v|
  ms << v
  median = ms.kth((ms.size - 1) / 2)
  puts median
end
```

### 2. 転倒数（Inversions）
```ruby
ms = AcSortedMultiSet.new
inv = 0
perm.each do |v|
  inv += ms.size - ms.count_le(v)
  ms << v
end
puts inv
```

### 3. 切り分け問題（ABC217D型）
```ruby
ss = AcSortedSet.new
ss << 0; ss << total_length
cuts.each do |pos|
  ss << pos
end
# posを含む区間の長さ
r = ss.lower_bound(pos)   # pos以上の最小の切れ目
l = ss.prev(pos)          # posより小さい最大の切れ目
puts r - l
```

### 4. K番目に大きい値（ABC234D型）
```ruby
ms = AcSortedMultiSet.new
data.each_with_index do |v, i|
  ms << v
  if i + 1 >= k
    puts ms.kth(ms.size - k)  # K番目に大きい = (size-K)番目
  end
end
```

### 5. 最近傍探索
```ruby
ms = AcSortedMultiSet.new
values.each do |v|
  unless ms.empty?
    lb = ms.lower_bound(v)
    pr = ms.prev(v)
    d = Float::INFINITY
    d = [d, (lb - v).abs].min if lb
    d = [d, (pr - v).abs].min if pr
    puts d
  end
  ms << v
end
```

## パフォーマンス

Ruby 3.2.3 での計測（AtCoderのRuby 3.4 YJITはこれより高速）:

| ベンチマーク | N | 実行時間 |
|---|---|---|
| ABC217D (add + lower_bound + prev) | 200,000 | 0.69 sec |
| 転倒数 (add + count_le) | 200,000 | 0.80 sec |
| ABC234D (add + kth) | 200,000 | 0.44 sec |
| Mixed操作 | 200,000 | 0.27 sec |

AtCoderの制限時間2秒に対して十分余裕があります。

## 内部実装

**配列分割方式**（Bucket Sorted Array）を採用。

- ソート済み配列を複数のバケット（小配列）に分割
- 各バケットの最大サイズは `BK * 2 = 3000`
- バケット特定は各バケットの末尾値で二分探索 O(log(N/BK))
- バケット内操作は二分探索 + 配列シフト O(BK)
- 現代CPUの配列シフト性能とキャッシュ局所性を活用

理論的計算量はO(√N)ですが、定数が小さく実用上十分高速です。

## ライセンス

MIT License. 自由にコピペ・改変してください。
