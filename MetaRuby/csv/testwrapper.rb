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
      klass
     end
  end
end

klass = DataWrapper.wrap('location.txt')
puts klass.new.class.instance_methods(false).inspect
#=>[:name, :name=, :country, :country=]???
