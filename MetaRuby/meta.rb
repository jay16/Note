puts "#{3 * 3}" #=> 9
puts eval("3 * 3") #=> 9

"#{def x(s)
    puts (s.upcase)
  end;
  (1..3).each { x('hello') }
}"
#=> HELLO\n  HELLO\n  HELLO\n

class Attr
  attr_accessor :aValue
  def initialize    
    @aVar = "Hello world"    
  end 
end
at = Attr.new
puts at.class.instance_methods(false).inspect
#=> [:aValue, :aValue=]
puts at.instance_eval { @aVar }            #=> "Hello world"    
puts at.instance_eval("@aVar")            #=> "Hello world" 

#puts "Enter the name of a string method(e.g upcase)"
#method_name = gets().chomp()
method_name = "upcase"
exp = "'hello world'." << method_name
puts eval(exp) #=> HELLO WORLD
puts "#{exp}"  #=> 'hello world'.upcase
puts "#{eval(exp)}" #=> ELLO WORLD

eval( 'def aMethod(x)
   return(x * 2)
end
 
num = 100
puts("This is the result of the calculation:")
puts(aMethod(num))')
#=> 200


String::class_eval { define_method(:bye){ puts "good bye" } }
"Hi".bye


def getBinding(str) 
   return binding() 
end 
str = "hello" 
puts eval("str + ' Fred'")                    #=> "hello Fred" 
puts eval("str + ' Fred'",getBinding("bye"))  #=> "bye Fred"

puts "hi".send(:upcase) #=> HI

hi = "hello"
hi << "world"
hi.freeze #注意，一旦对象被冻结，将不能够解冻。 
#hi << "!!!" #=>meta.rb:57:in `<main>': can't modify frozen String (RuntimeError)
if !(hi.frozen?) then    
   a << "!!!!"
end
puts hi


