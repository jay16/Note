#coding: utf-8
require 'nokogiri'
require 'open-uri'
require 'yaml/store'

#2012-05-17更新的文档
def get_sys_errinfo(url)
		html = open(url).read
		yml = YAML::Store.new "oauth2error-2012-05-17.yml"
		
		table = html.match(/(<table.*?>.*?<\/table>)/m).to_s
		while table.length > 0
		  html = html.gsub(table,"")
				tr = table.match(/(<tr.*?>.*?<\/tr>)/m).to_s
				while tr.length > 0
						table = table.gsub(tr,"")
						td = tr.match(/(<td.*?>.*?<\/td>)/m).to_s
						hash = Hash.new
						rule = %w(code error info)
						@index = 0
						while td.length > 0
								tr = tr.gsub(td,"")
								value = td.gsub(/(<td.*?>)|(<\/td>)/,"")
								puts value
								hash[rule[@index]] = value
								@index += 1
								td = tr.match(/(<td.*?>.*?<\/td>)/m).to_s
						end
				  puts hash
						yml.transaction do
						yml[hash[rule[0]]] = hash
						tr = table.match(/(<tr.*?>.*?<\/tr>)/m).to_s
						end
				end
				table = html.match(/(<table.*?>.*?<\/table>)/m).to_s
		end
end
#get_sys_errinfo("http://open.weibo.com/wiki/Error_code")

def get_http_errinfo(url)
  yml = YAML::Store.new "oauth2error-2012-03-06.yml"
  html = open(url).read
  ul = html.match(/<ul>(<li> 10001.*?)<\/ul>/m).to_s
  li = ul.match(/<li>(.*?)<\/li>/m).to_s
  while li.length > 0
    ul = ul.gsub(li,"")
    li = li.gsub(/( )|(　)|(\n)|(\t)|(<li>)|(<\/li>)/,"")
    hash = Hash.new
    hash["code"] = li.split("：")[0]
    hash["info"] = li.split("：")[1]
    yml.transaction do
      yml[hash["code"]] = hash
    end
    puts hash
    li = ul.match(/<li>(.*?)<\/li>/m).to_s
  end
end
#get_http_errinfo("http://open.weibo.com/wiki/Help/error")

def check_errinfo(code)
  yml = YAML.load_file("oauth2error-2012-03-06.yml")
  puts yml[code].class
  puts yml[code]["code"]
  puts yml[code]["error"]
  puts yml[code]["info"]
  puts yml[code]
end
check_errinfo("21327")


























