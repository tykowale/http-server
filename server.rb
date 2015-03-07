require 'socket'
require 'uri'

hostname = 'localhost'
port = 2000
path = <<-HTML
<html>
<head>
  <title>Welcome</title>
</head>
<body>
  <h1>Hello World</h1>
  <p>Welcome to the world's simplest web server.</p>
  <p><img src='http://i.imgur.com/A3crbYQ.gif'></p>
</body>
</html>
HTML

def controller(request)
  request_line = request.split(' ')[1]
  path = URI(request_line).path
end

server = TCPServer.new(port)
loop {
  client = server.accept
  response = client.gets
  client.print "HTTP/1.1 200 OK\r\n" +
               "Date: #{Time.now.ctime}\r\n" +
               "Server: #{`uname -sr`}" +
               "Content-Type: text/html; charset=UTF-8\r\n" +
               "Content-Length: #{path.bytesize}\r\n" +
               "Connection: close\r\n"
  client.print "\r\n"
  client.print path
  client.close
}
