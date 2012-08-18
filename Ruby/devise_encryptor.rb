# encoding: utf-8
#http://www.tmtm.org/en/mysql/ruby/
require "mysql"
require 'active_support/core_ext/string'

class Msql
  #@@conv = Iconv.new("UTF-8", "GBK")
  @@msql = Mysql.init
  @@msql.options(Mysql::SET_CHARSET_NAME, 'utf8')
  def initialize(username="root",password="123456",database="social-dev")
    @database = database
    @@msql.real_connect("localhost",username,password,database)
  end
  
  def tables
    @@msql.list_tables
  end
  
  def describe(table="users")
    if tables.include?(table)
				  fields = Array.new
				  result = @@msql.query("DESCRIBE #{table};")
				  result.each { |f| fields << f[0] }
				  result.free
				  fields
    else
      puts "Descri-Error:No #{table} in #{@database}"
    end
  end
  
  def method_missing(name, *args)
    query_str = split_method(name, *args)
    super unless query_str
    
    self.class.send(:define_method,name,
      lambda { |*args| 
								result = @@msql.query(query_str)
								field = Array.new
								result.each { |row| field << row }
								result.free
								field
      }).call
  end
  
  def split_method(name, *args)
    #get table name
    method_arr ||= name.to_s.split("_")
    table_name = method_arr.shift
    #get column names
    is_find = false
    key = ""
    if method_arr.at(method_arr.length-2) == "by"
      is_find = true
				  key = method_arr.pop
				  method_arr.pop
    end
    is_find &&= describe(table_name).include?(key)
    
    #get by_column
    field_arr ||= method_arr
    field_arr.map! { |f| f.tableize.singularize }
    unless tables.include?(table_name) || field_arr.empty?
      puts "Table-Error:No '#{table_name}' in #{@database}!"
      return false
    end
 
    if !is_find
      puts "Find-Error:Not '#{key}' in #{table_name}!"
      return false
    elsif !field_arr.inject(true) { |res,f| res and describe(table_name).include?(f) }
      puts "Field-Error:Not all '#{field_arr.to_s}' in #{table_name}!"
      return false
    end
    
    field_str = String.new
    if field_arr.empty?
      field_str = "*"
    else
      field_str = field_arr.inject { |res,f| res += "," + f}
    end
		  
		  query_str = "SELECT #{field_str} FROM #{table_name}"
		  query_str << " WHERE #{key} = #{args[0]}" if is_find
  end
  
  def close
    @@msql.close if @@msql
  end
end

test = Msql.new
puts test.describe("user").inspect
#puts test.users_email_EncryptedPassword_by_id(2)
#puts test.class.instance_methods(false)
test.close

#a1 = %w(a b c d e f)
#a2 = a1.values_at(1,2)
##puts a2.inspect
##puts /^(a)_(b)_(\w*)$/.match("a_b_c_d_e_f_g").captures # => ["a", "b", "c_d_e_f_g"] 
#puts /^find_(all_by|by)_([_a-zA-Z]\w*)$/.match("find_by_a_and_b_and_c").captures
#puts /1 \+ 2 = 3\?/.match('Does 1 + 2 = 3?')
#puts /^(a)_(b)_(\w*)$/.match("a_b_c_d_e_f_g")#.captures
#b = /<.+?>/.match("<a>as<b>")
#puts b.size
#puts b
#puts /\z(real)/.match("realistsurreal")
