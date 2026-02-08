# SortedMultiset / SortedSet for AtCoder (Ruby)
# Usage: copy-paste into your submission
class SortedMultiset
  BK = 1500
  attr_reader :size
  def initialize(a=nil)
    @a=[]; @size=0
    if a; b=a.sort; i=0; while i<b.size; @a<<b[i,BK]; i+=BK; end; @size=b.size; end
  end
  def add(v)
    if @a.empty?; @a=[[v]]; @size=1; return self; end
    lo,hi=0,@a.size-1; while lo<hi; m=(lo+hi)>>1; @a[m][-1]<v ? lo=m+1 : hi=m; end
    b=@a[lo]; lo2,hi2=0,b.size; while lo2<hi2; m=(lo2+hi2)>>1; b[m]<v ? lo2=m+1 : hi2=m; end
    b.insert(lo2,v); @size+=1
    if b.size>BK<<1; mid=b.size>>1; @a.insert(lo+1,b.slice!(mid..)); end; self
  end
  alias << add
  def delete(v)
    return false if @a.empty?
    lo,hi=0,@a.size-1; while lo<hi; m=(lo+hi)>>1; @a[m][-1]<v ? lo=m+1 : hi=m; end
    b=@a[lo]; lo2,hi2=0,b.size; while lo2<hi2; m=(lo2+hi2)>>1; b[m]<v ? lo2=m+1 : hi2=m; end
    return false if lo2>=b.size||b[lo2]!=v; b.delete_at(lo2); @size-=1; @a.delete_at(lo) if b.empty?; true
  end
  def delete_all(v); c=0; c+=1 while delete(v); c; end
  def include?(v)
    return false if @a.empty?
    lo,hi=0,@a.size-1; while lo<hi; m=(lo+hi)>>1; @a[m][-1]<v ? lo=m+1 : hi=m; end
    b=@a[lo]; lo2,hi2=0,b.size; while lo2<hi2; m=(lo2+hi2)>>1; b[m]<v ? lo2=m+1 : hi2=m; end
    lo2<b.size&&b[lo2]==v
  end
  alias member? include?
  def lower_bound(v)
    return nil if @a.empty?
    lo,hi=0,@a.size-1; while lo<hi; m=(lo+hi)>>1; @a[m][-1]<v ? lo=m+1 : hi=m; end
    b=@a[lo]; return nil if b[-1]<v
    lo2,hi2=0,b.size; while lo2<hi2; m=(lo2+hi2)>>1; b[m]<v ? lo2=m+1 : hi2=m; end; b[lo2]
  end
  def upper_bound(v)
    return nil if @a.empty?
    lo,hi=0,@a.size-1; while lo<hi; m=(lo+hi)>>1; @a[m][-1]<=v ? lo=m+1 : hi=m; end
    b=@a[lo]; return nil if b[-1]<=v
    lo2,hi2=0,b.size; while lo2<hi2; m=(lo2+hi2)>>1; b[m]<=v ? lo2=m+1 : hi2=m; end; b[lo2]
  end
  def reverse_lower_bound(v); @a.empty? ? nil : ((c=count_le(v))>0 ? kth(c-1) : nil); end
  def prev(v); @a.empty? ? nil : ((c=count_less(v))>0 ? kth(c-1) : nil); end
  alias next_val upper_bound
  def kth(k)
    return nil if k<0||k>=@size
    @a.each{|b| s=b.size; return b[k] if k<s; k-=s}; nil
  end
  alias [] kth
  def count_less(v)
    c=0; @a.each{|b| if b[-1]<v; c+=b.size
    else; lo,hi=0,b.size; while lo<hi; m=(lo+hi)>>1; b[m]<v ? lo=m+1 : hi=m; end; return c+lo; end}; c
  end
  def count_le(v)
    c=0; @a.each{|b| if b[-1]<=v; c+=b.size
    else; lo,hi=0,b.size; while lo<hi; m=(lo+hi)>>1; b[m]<=v ? lo=m+1 : hi=m; end; return c+lo; end}; c
  end
  def count_range(l,h); l>h ? 0 : count_le(h)-count_less(l); end
  def count(v); count_range(v,v); end
  def index(v); p=count_less(v); p<@size&&kth(p)==v ? p : nil; end
  def min; @a.empty? ? nil : @a[0][0]; end
  def max; @a.empty? ? nil : @a[-1][-1]; end
  def shift; return nil if @a.empty?; v=@a[0].shift; @size-=1; @a.shift if @a[0].empty?; v; end
  def pop; return nil if @a.empty?; v=@a[-1].pop; @size-=1; @a.pop if @a[-1].empty?; v; end
  def empty?; @size==0; end
  def each(&bl); return enum_for(:each) unless bl; @a.each{|b|b.each(&bl)}; end
  def reverse_each(&bl); return enum_for(:reverse_each) unless bl; @a.reverse_each{|b|b.reverse_each(&bl)}; end
  def to_a; @a.flatten; end
end

class SortedSet
  attr_reader :size
  def initialize(a=nil); @ms=SortedMultiset.new; @size=0
    if a; h={}; a.each{|v| next if h[v]; h[v]=1; @ms.add(v)}; @size=@ms.size; end; end
  def add(v); return false if @ms.include?(v); @ms.add(v); @size=@ms.size; true; end
  alias << add
  def delete(v); r=@ms.delete(v); @size=@ms.size if r; r; end
  def include?(v); @ms.include?(v); end
  alias member? include?
  def lower_bound(v); @ms.lower_bound(v); end
  def upper_bound(v); @ms.upper_bound(v); end
  def reverse_lower_bound(v); @ms.reverse_lower_bound(v); end
  def prev(v); @ms.prev(v); end
  def next_val(v); @ms.upper_bound(v); end
  def kth(k); @ms.kth(k); end
  alias [] kth
  def count_less(v); @ms.count_less(v); end
  def count_le(v); @ms.count_le(v); end
  def count_range(l,h); @ms.count_range(l,h); end
  def index(v); @ms.index(v); end
  def min; @ms.min; end
  def max; @ms.max; end
  def shift; v=@ms.shift; @size=@ms.size; v; end
  def pop; v=@ms.pop; @size=@ms.size; v; end
  def empty?; @ms.empty?; end
  def each(&bl); @ms.each(&bl); end
  def reverse_each(&bl); @ms.reverse_each(&bl); end
  def to_a; @ms.to_a; end
end
