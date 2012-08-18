require "open-uri"
require "yaml"

yml = YAML.load_file("emotions.yml")
yml.each do |y|

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
				open("emotions/#{y[1]['type']}/gif/#{gif}","wb"){|f|f.write(data)}
		end
  
  if File.extname(y[1]["url"]) == ".swf"
    begin
						data=open(y[1]["url"]){|f|f.read}
						swf = File.basename(y[1]["url"])
				rescue OpenURI::HTTPError => info
						puts info
						puts y[1]["icon"]
		  else
				  open("emotions/#{y[1]['type']}/swf/#{swf}","wb"){|f|f.write(data)}
				end
		end
end
