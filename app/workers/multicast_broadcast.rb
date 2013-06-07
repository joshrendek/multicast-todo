require 'socket'
require 'java'
class MutlicastBroadcast
  include SuckerPunch::Worker

  def perform
    addr = "225.4.5.6"
    port = 5000
    begin
      socket = UDPSocket.open
      puts javax.servlet.getServletContext.getServerPort.to_s
      msg = ( 3000 ).to_s
      socket.send(msg, 0, addr, port)
    ensure
      socket.close
    end

    Rails.logger.info "Broadcasted"

    sleep 10
    SuckerPunch::Queue[:broadcast].async.perform
  end
end
