require 'socket'
class MutlicastBroadcast
  include SuckerPunch::Worker

  def perform
    addr = "225.4.5.6"
    port = 5000
    begin
      socket = UDPSocket.open
      msg = Rails::Server.new.options[:Port].to_s
      socket.send(msg, 0, addr, port)
    ensure
      socket.close
    end

    Rails.logger.info "Broadcasted"

    sleep 10
    SuckerPunch::Queue[:broadcast].async.perform
  end
end
