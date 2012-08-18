#除引用系统rb外，require中不能用相对路径。

#引用单个文件
#require File.expand_path("../require_file.rb",__FILE__)
puts File.expand_path("../require_file.rb",__FILE__)
#/home/jay/ruby/MetaRuby/Ruby/require_file.rb

#require File.dirname(__FILE__)+"/require_file.rb"
puts File.dirname(__FILE__)+"/require_file.rb"
#./require_file.rb


#fails
#require File.join(__FILE__,"../require_file")
puts File.join(__FILE__,"../require_file")
#loaderror.rb/../require_file


