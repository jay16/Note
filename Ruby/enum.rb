#即依次为集合内的各个元素来执行块的内容。当所有元素为真时，all返回true
puts %w{ant bear cat}.all? { |word| word.length >= 3 } #=> true
puts %w{ant hello cat}.all? { |word| word.length >= 4 } #=> false
puts [nil, true, 99].all? #=> false
puts [1, true, 99].all? #=> true

#当所有元素为假时，any返回false
puts %w{ant bear cat}.any? { |word| word.length >= 4 } #=> false
puts %w{ant hello cat}.any? { |word| word.length >= 4 } #=> true
puts [nil, true, 99].any? #=> true
puts [nil, nil, nil].all? #=> false

#每个元素执行块block的内容，并将结果存入一个新数组中，最后返回该数组
arr = [1, 2, 3, 4]
ar1 = arr.collect { |a| a*a }
ar2 = arr.map { |a| a*4 }
puts arr.inspect #=> [1, 2, 3, 4]
puts ar1.inspect #=> [1, 4, 9, 16]
puts ar2.inspect #=> [4, 8, 12, 16]

#使用元素及其索引进行循环操作的迭代器，即使用两个参数调用块
hash = Hash.new
%w(cat dog wombat).each_with_index do |item, index|
  hash[index] = item
end
puts hash.inspect #=> {0=>"cat", 1=>"dog", 2=>"wombat"}

#返回计算值首次为真的那个元素
dec = (1..10).detect do |d|
  d%5 == 0 and d%7 == 0
end
puts dec #=> nil

dec = (1..100).detect do |d|
  d%5 == 0 and d%7 == 0
end
puts dec #=> 35

dec = (1..1000).detect do |d|
  d%5 == 0 and d%7 == 0
end
puts dec #=> 35

#若计算值为真，则把该元素存入数组，最后返回该数组
arr = Array.new
arr = (1..10).find_all { |i| i%3 == 0 }
puts arr.inspect #=> [3, 6, 9]

arr = Array.new
arr = (1..10).select { |i| i%3 == 0 }
puts arr.inspect #=> [3, 6, 9]

#若pattern === item ，则把该元素存入数组，最后返回该数组
arr = Array.new
arr = (1..100).grep(33..40)
puts arr.inspect #=> [33, 34, 35, 36, 37, 38, 39, 40]

#在每一步骤中，memo要被设置为由块计算后返回的值
sum = [1, 2, 3, 4, 5].inject(0) do |result, item|
  result + item
end
puts sum #=> 15

#若省略了初始值initial的话，开始时会把第1和第2个元素传递给块
sum = [1, 2, 3, 4, 5].inject do |result, item|
  result + item
end
puts sum #=> 15

# 查找最长的单词
longest = %w{ cat sheep bear }.inject do |memo,word|
  memo.length > word.length ? memo : word
end
puts longest #=> sheep

# 查找最长单词的长度。
longest = %w{ cat sheep bear }.inject(0) do |memo,word|
  memo >= word.length ? memo : word.length
end
puts longest #=> 5



a = %w(albatross dog horse)
puts a.min #=> "albatross"
puts a.min {|a,b| a.length <=> b.length } #=> "dog"
puts a.max #=> "horse"
puts a.max {|a,b| a.length <=> b.length } #=> "albatross"

#若对某元素执行块的结果为真，则把该元素归入第一个数组；若为假则将其归入第二个数组,最后生成并返回一个包含这两个数组的新数组。
yes = no = Array.new
yes, no = (1..6).partition{ |i| (i&1).zero? and i%2 ==0 }
puts yes.inspect #=> [2, 4, 6]
puts no.inspect #=> [1, 3, 5]

#对enum内的各元素依次传入块中进行计算，若计算值为假则将该元素存入数组，最后返回该数组
#注：reject有不合格者，不合格品的意思
no = Array.new
no = (1..10).reject { |i| i%3 == 0 }
puts no.inspect #=> [1, 2, 4, 5, 7, 8, 10]

#对所有元素进行升序排列后返回这个新的数组
asc = dec = Array.new
asc = %w(bear apple dog cat).sort
puts asc.inspect #=> ["apple", "bear", "cat", "dog"]
asc = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1].sort
puts asc.inspect #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
asc = (1..10).sort { |a, b| a <=> b }
dec = (1..10).sort { |a, b| b <=> a }
puts asc.inspect #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
puts dec.inspect #=> [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]


puts 3.between?(1, 5)               #=> true
puts 6.between?(1, 5)               #=> false
puts 'cat'.between?('ant', 'dog')   #=> true
puts 'gnu'.between?('ant', 'dog')   #=> false

class SizeMatters
  include Comparable
  attr :str
  def <=>(anOther)
    str.size <=> anOther.str.size
  end
  def initialize(str)
    @str = str
  end
  def inspect
    @str
  end
end

s1 = SizeMatters.new("Z")
s2 = SizeMatters.new("YY")
s3 = SizeMatters.new("XXX")
s4 = SizeMatters.new("WWWW")
s5 = SizeMatters.new("VVVVV")

puts (s1 < s2).inspect                   #=> true
puts s4.between?(s1,s3).inspect          #=> false
puts s4.between?(s3,s5).inspect          #=> true
puts [s3, s2, s5, s4, s1].sort.inspect   #=> [Z, YY, XXX, WWWW, VVVVV]




