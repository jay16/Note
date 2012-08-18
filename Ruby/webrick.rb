require 'webrick'
include WEBrick

#a function stub to start WEBrick
def start_WEBrick(config = {})
  config.update(:Port => 3000)

  server = HTTPServer.new(config)
  yield server if block_given?

  ['INT', 'TERM'].each do |signal|
    trap(signal) { server.shutdown }
  end
  server.start
end

class HelloServlet < HTTPServlet::AbstractServlet
  def do_GET(req, res)
    res["content-type"] = "text/html; charset=UTF-8" 
    res.body = %{
      <html>
      <body>
      Hello World!
      </body>
      </html>
    }
  end

  alias do_POST do_GET
end

start_WEBrick do |server|
  #servlet "/hello" 
  server.mount("/hello", HelloServlet)
end

#http://localhost:3000/hello
