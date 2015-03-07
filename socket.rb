require 'socket'

hostname = 'localhost'
port = 2000
path = '/'
request = "GET #{path} HTTP/1.1\r\n\r\n"

socket = TCPSocket.open(hostname, port)
socket.print(request)
response = socket.read
headers, body = response.split("\n\n")
print body