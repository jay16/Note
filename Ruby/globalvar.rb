#$! 最近一次的错误信息 
#$@ 错误产生的位置 
#$_ gets最近读的字符串 
#$. 解释器最近读的行数(line number) 
#$& 最近一次与正则表达式匹配的字符串 
#$~ 作为子表达式组的最近一次匹配 
#$n 最近匹配的第n个子表达式(和$~[n]一样) 
#$= 是否区别大小写的标志 
#$/ 输入记录分隔符 
#$\ 输出记录分隔符 
#$0 Ruby脚本的文件名 
#$* 命令行参数 
#$$ 解释器进程ID 
#$? 最近一次执行的子进程退出状态 

#获取当前的文件名称
puts __FILE__ # globalvar.rb
#获取当前文件的目录名称
puts File.dirname(__FILE__) # .
#获取当前文件的完整名称 
#当要获取完整的路径时需要require 'pathname',代码如下： 
require 'pathname' 
puts Pathname.new(__FILE__).realpath 
#/home/jay/ruby/MetaRuby/Ruby/globalvar.rb

#获取当前文件的完整目录 
require 'pathname' 
puts Pathname.new(File.dirname(__FILE__)).realpath
#/home/jay/ruby/MetaRuby/Ruby

#$& #在当前作用域中,正则表达式最后一次匹配成功的字符串
puts /(foo)(bar)(BAZ)?/ =~ "hellofoobarbaz" # 0
puts $& #foobar
puts Regexp.last_match #foobar

#$~ #在当前作用域中,最后一次匹配成功的相关信息
puts $~ #foobar
puts $1 #foo
puts $2 #bar
puts $~[1] #foobar
puts $~.size #4
puts $~.inspect ##<MatchData "foobar" 1:"foo" 2:"bar" 3:nil>

#$` #在当前作用域中,正则表达式最后一次匹配成功的字符串前面的字符串
puts $` #hello
puts Regexp.last_match.pre_match #hello

#$' #在当前作用域中,正则表达式最后一次匹配成功的字符串后面的字符串
puts $' #baz
puts Regexp.last_match.post_match #baz

#$+ #在当前作用域中,正则表达式最后一次匹配成功的字符串部分中,与最后一个括号相对应的那部分字符串
puts $+ #bar
last = $~.size-2
puts $~[last] #bar
puts eval("$#{last}") #bar
puts Regexp.last_match[last] #bar

#$$ #当前运行中的Ruby进程的pid
puts $$ #13174


#$: #包含一个数组,其内容是load或require加载文件时用的搜索目录列表
puts $:
puts $LOAD_PATH 

#ENV #包含程序的环境变量，是一个Hash对象
ENV.each{|k,v| puts "#{k}=>#{v}"} 

#DATA，读取__END__后程序行的输入流。如果__END__未出现在代码中则无定义
#STDERR，STDIN，STDOUT 标准输入、输出、错误流 
#RUBY_PLATFORM，ruby解释器平台 
puts RUBY_PLATFORM #i686-linux

"/home/jay/rails/social-web/app/views/sina_weibo/favorites.html.erb:32: syntax error, unexpected '<'<%= render :partial => sina_p..." =~ /(.*?:)(\d+)/
puts $1
puts $2
puts $'



