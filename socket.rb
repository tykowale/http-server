require 'socket'

hostname = 'localhost'
port = 2000
request = "GET HTTP/1.1\r\n\r\n"

socket = TCPSocket.open(hostname, port)
socket.print(request)
response = socket.read
headers, body = response.split("\r\n\r\n", 2)
print headers