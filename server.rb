require 'socket'
require 'uri'

hostname = 'localhost'
port = 2000
welcome = <<-HTML
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

profile = <<-HTML
<html>
<head>
  <title>My Profile Page</title>
</head>
<body>
  <p>This is my profile page.</p>
</body>
</html>
HTML

error = <<-HTML
<html>
<head>
  <title>Not Found</title>
</head>
<body>
  <p>This page was not found.</p>
</body>
</html>
HTML

def controller(request)
  request_line = request.split(' ')[1]
  path = URI(request_line).path
  return path
end

server = TCPServer.new(port)
loop {
  client = server.accept
  response = client.gets
  if controller(response)[1..-1] == "welcome"
    client.print "HTTP/1.1 200 OK\r\n" +
               "Date: #{Time.now.ctime}\r\n" +
               "Server: #{`uname -sr`}" +
               "Content-Type: text/html; charset=UTF-8\r\n" +
               "Content-Length: #{welcome.bytesize}\r\n" +
               "Connection: close\r\n"
    client.print "\r\n"
    client.print welcome
  elsif controller(response)[1..-1] == "profile"
    client.print "HTTP/1.1 200 OK\r\n" +
               "Date: #{Time.now.ctime}\r\n" +
               "Server: #{`uname -sr`}" +
               "Content-Type: text/html; charset=UTF-8\r\n" +
               "Content-Length: #{profile.bytesize}\r\n" +
               "Connection: close\r\n"
    client.print "\r\n"
    client.print profile
  else
    client.print "HTTP/1.1 404 NOT FOUND\r\n" +
               "Date: #{Time.now.ctime}\r\n" +
               "Server: #{`uname -sr`}" +
               "Content-Type: text/html; charset=UTF-8\r\n" +
               "Content-Length: #{error.bytesize}\r\n" +
               "Connection: close\r\n"
    client.print "\r\n"
    client.print error
  end
  client.close
}
