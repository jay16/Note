#encoding: utf-8
require "open-uri"
require 'yaml/store'

def has_not(arr,item)
	arr.each do |a|
	  return false if a == item
	end
	return true
end

yml = YAML.load_file("emotions.yml")

category = Array.new
yml.each do |y|
  if y[1]["type"] == "face"
  puts y[1]["category"]
  category.push(y[1]["category"]) if has_not(category,y[1]["category"])
  end
end
ca=Array.new
ca = %w(恐龙宝贝 星座 哈皮兔 大耳兔)
face = YAML::Store.new "face.yml"
ca.each do |c|
  a = Array.new
		yml.each do |y|
				if y[1]["category"] == c
				   hash = Hash.new
				   hash["mean"] = y[1]["value"]
				   hash["name"] = File.basename(y[1]["icon"])
				   h = Hash.new
				   h[y[0]] = hash
				   a.push(h)
				   begin
							data=open(y[1]["icon"]){|f|f.read}
							if File.extname(y[1]["icon"]) == ".gif"
									gif = File.basename(y[1]["icon"])
							else
									gif = "#{File.basename(y[1]['icon'])}.gif"
							end
							rescue OpenURI::HTTPError => info
									puts info
									puts y[1]["icon"]
							else
									open("face/#{gif}","wb"){|f|f.write(data)}
							end
				end
		end
		face.transaction do
		face[c] = a
		end
end

