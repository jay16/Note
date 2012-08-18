#encoding: utf-8

#批量生产module、methods
modules = %W[Sina QQ Wangyi]
methods = %W[api_key api_secret redirect_uri site authorize_url token_url]
modules.each do |mod|
  modul = Object.const_set(mod,Module.new) 
  methods.each do |meth|
				modul.module_eval <<-RUBY
				 module Config
							class << self
									def #{meth}=(val)
								   @@#{meth}=val
									end
									def #{meth}
									  @@#{meth}
									end
							end
				 end
				RUBY
  end
end

  
#批量生产methods
#module Sina
#  module Config
#  
#    configs = %w(api_key api_secret redirect_uri site authorize_url token_url)
#				configs.each do |c_m|
#				  name = "self." + c_m
#				  self.class_eval( "def #{name}; @@#{c_m};end" ) 
#				  self.class_eval( "def #{name}=(val); @@#{c_m}=val;end" ) 
#				end   
#    
#  end
#end

