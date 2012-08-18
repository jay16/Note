puts 1.methods == 1.class.instance_methods
#=> true
C = Class.new
puts C.ancestors.inspect
#=> [C, Object, Kernel, BasicObject]
puts C.class
#=> Class
puts C.superclass
#=> Object
puts C.superclass.superclass
#=> BasicObject
puts C.superclass.superclass.superclass
#=> nil

class String
  def getsize
    self.size
  end
end
puts "My size is:".getsize
#=> 11

#Eigenclass:an object’s own class => Singlton Methods

class Rubyist1
  def self.who
    "rubyist1"
  end
end
puts Rubyist1.who

class Rubyist2
  class << self
    def who
      "rubyist2"
    end
  end
end
puts Rubyist2.who

class Rubyist3; end
def Rubyist3.who
  "rubyist3"
end
puts Rubyist3.who

class Rubyist4; end
Rubyist4.instance_eval do
  def who
    "rubyist4"
  end
end
puts Rubyist4.who

class Rubyist5; end
class << Rubyist5
  def who
    "rubyist5"
  end
end
puts Rubyist5.who
