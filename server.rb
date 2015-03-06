require 'socket'

hostname = 'localhost'
port = 2000

def input_reader(string)
  string.chomp!
  if string.downcase == 'home'
    return "Welcome Home!"
  elsif string.downcase == 'profile'
    return "Name: Ty \nProfile: Incomplete"
  else
    return "What does that mean?"
  end
end

server = TCPServer.new(port)  # Socket to listen on port 2000
loop {                         # Servers run forever
  client = server.accept       # Wait for a client to connect
  client.puts Time.now.ctime  # Send the time to the client
  input = client.gets
  client.puts input_reader(input)
  client.close                 # Disconnect from the client
}

s = TCPSocket.open(hostname, port)

while line = s.gets   # Read lines from the socket
  puts line.chop
end

s.close