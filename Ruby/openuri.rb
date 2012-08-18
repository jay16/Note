require 'open-uri'

s = "http://hi.baidu.com/kenrome/blog/item/5ff6002461121037d5074263.html"

		open s
		rescue => ex
			if ex.message =~  /404 *Not *Found/i
			puts "#{s} url_invalid"
			else
			puts "#{s}  url_error"
		end
		puts s

