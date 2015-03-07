require 'socket'

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

request = "GET HTTP/1.1\r\n\r\n"

server = TCPServer.new(port)
loop {
  client = server.accept
  client.puts "Date: #{Time.now.ctime}"
  client.puts "Server: #{`uname -sr`}"
  client.puts "Content-Type: text/html; charset=UTF-8"
  client.puts "Content-Length: #{content.length}"
  client.puts "Connection: close"
  client.puts
  client.puts content
  client.close
}

socket = TCPSocket.open(hostname, port)
socket.print(request)
response = socket.read

