require 'socket'

hostname = 'localhost'
port = 2000
path = 'path'
request = "GET #{path} HTTP/1.1\r\n\r\n"

socket = TCPSocket.open(hostname, port)
socket.print(request)
response = socket.read
headers, body = response.split("\r\n\r\n")
print headers