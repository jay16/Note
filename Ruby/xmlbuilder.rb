require 'builder'

xm = Builder::XmlMarkup.new(:target=>STDOUT, :indent=>2)
xm.instruct!
xm.declare!(:DOCTYPE, :html, :PUBLIC, 
  "-//W3C//DTD XHTML 1.0 Strict//EN", 
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd")
xm.html {
  xm.head {
    xm.title "Hello" 
  }
  xm.body {
    xm.comment! "This is my page!" 
    xm.h1 "Welcome to my home!" 
    xm.h2 "Nice to see you." 
    xm.div(:class => "content") {
      xm.text! "line"; xm.br
      xm.text! "another line"; xm.br
    }
  }
}
#<?xml version="1.0" encoding="UTF-8"?>
#<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
#<html>
#  <head>
#    <title>Hello</title>
#  </head>
#  <body>
#    <!-- This is my page! -->
#    <h1>Welcome to my home!</h1>
#    <h2>Nice to see you.</h2>
#    <div class="content">
#line      <br/>
#another line      <br/>
#    </div>
#  </body>
#</html>
#輸出到檔案
#File.open('x.xml', 'w') do |f|
#  xm = Builder::XmlMarkup.new(:target => f, :indent => 2)

#  xm.instruct!
#  xm.book "Ruby is good programming language!" 
#end


