require 'socket'
require 'ipaddr'
class MulticastDiscovery
  include SuckerPunch::Worker

  def perform

    addr = "225.4.5.6"
    port = 5000
    ip =  IPAddr.new(addr).hton + IPAddr.new("0.0.0.0").hton
    sock = UDPSocket.new
    sock.setsockopt(Socket::IPPROTO_IP, Socket::IP_ADD_MEMBERSHIP, ip)
    sock.bind(Socket::INADDR_ANY, port)

    msg, info = sock.recvfrom(1024)
    puts "MSG: #{msg} from #{info[2]} (#{info[3]})/#{info[1]} len #{msg.size}"
    Server.where(ip: info[2], port: msg.to_i).first_or_create!

    sleep 10

    SuckerPunch::Queue[:discovery].async.perform
  end

end



