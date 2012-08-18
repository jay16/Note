ex = 'expired_token: {"error":"expired_token","error_code":21327,"request":"/2/statuses/public_timeline.json"}'

def covert_to_hash(exception)
  hash = Hash.new
  #hash["title"] = exception.code
  body = exception.to_s.match(/{(.*?)}/)[0].gsub(/({)|(})|(")/,"")
  tmp ||= body.split(",")
  tmp.each do |item|
    hash["#{item.split(":")[0]}"] = item.split(":")[1]
  end
  hash
end

h ||= covert_to_hash(ex)

h.each do |key,value|
 puts "key:#{key},value:#{value}"
end
puts h["error"]
