class DataWrapper
  def self.wrap(file_name)
    data = File.new(file_name)
    header = data.gets.chomp
    names = header.split(",")
    data.close
    class_name = File.basename(file_name, ".txt").capitalize
    klass = Object.const_set(class_name, Class.new)

    klass.class_eval do
      attr_accessor *names
      #puts names.inspect =>[name, country]
      define_method(:initialize) do |*values|
        names.each_with_index do |name, i|
          instance_variable_set("@"+name, values[i])
        end
      end
     
      define_method(:to_s) do
        str = "<#{self.class}:"
        names.each { |name| str << "#{name}=#{self.send(name)} " }
        str + ">"
      end
      alias_method :inspect, :to_s
    end
    
    def klass.read
      array = []
      data = File.new(self.to_s.downcase+".txt")
      data.gets #throw away the header
      data.each do |line|
        line.chomp!
        values = eval("[#{line}]")
        #values.class => Array
        array << self.new(*values)
      end
      data.close
      array
    end
    klass
  end
end

klass = DataWrapper.wrap('location.txt')
list = klass.read
list.each do |location|
   puts location.to_s
  #puts location.class.instance_methods(false)
  #puts "#{location.name} is from the #{location.country}"
end
