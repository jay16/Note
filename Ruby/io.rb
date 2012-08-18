#encoding: utf-8
#文件读写
File.open(__FILE__) do |file|
  contents = file.read
  puts contents
end

#写模式打开文件
File.open(__FILE__, 'a') do |file|
  file.puts "#last-modify-time '%s'" %Time.now
end
#last-modify-time '2012-07-19 15:18:51 +0800

#逐行　each_lin
#逐字节　ｅａｃｈ_ｂｙｔｅ
File.open(__FILE__, 'r') do |file|
  file.each_line do |line|
    puts "#{file.lineno}:#{line}"
  end
end
#last-modify-time '2012-07-19 15:21:50 +0800'

#在不带有代码块的情况下使用File.open,需要手工关闭文件
file = File.open(__FILE__)
file.close

#标准输入输出
#重定向stdout
File.open(__FILE__, 'a') do |file|
    $stdout = file
    puts "#last-modify-time '%s'" %Time.now
    $stdout = STDOUT    #将$stdout的初始值改回原样
end
#last-modify-time '2012-07-19 15:25:16 +0800'

#标准输入输出的初始值
#$stdin = STDIN
#$stdout = STDOUT
#$stderr = STDERR
 
puts "演示从stdin读取信息"
ARGF.each_line do |line|
    print "[#{line.strip}]\n"
    if line.strip == "end"  #判断字符串内容是否相等
        break
    end
end

#last-modify-time '2012-07-19 15:27:17 +0800'
