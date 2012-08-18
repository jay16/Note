#equal? #比较两个值是否指向同一个对象的引用
a = "Ruby"
b = c ="Ruby"
puts a.equal?(b) # false
puts b.equal?(c) # true
#实际上是比较两个对象的ID是否相同
puts a.object_id == b.object_id # false
puts b.object_id == c.object_id # true

#eql? #Two strings are equal if they have the same length and content.
puts a.eql?(b) # true
puts b.eql?(c) # true

#== #比较的是两个对象的内容是否相同
puts a == b # true

#===
#Range中===用于判断等号右边的对象是否包含于等号左边的Range
puts (1..10) === 5 # true
#正则表达式中用于判断一个字符串是否匹配模式
puts /\d+/ === "123" # true
#Class定义===来判断一个对象是否为类的实例
puts String === "s" # true
#Symbol定义===来判断等号两边的符号对象是否相同
puts :s === "s" # false
