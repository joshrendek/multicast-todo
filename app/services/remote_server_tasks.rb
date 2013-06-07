class RemoteServerTasks
  def initialize(server_ip, server_port)
    @ip = server_ip
    @port = server_port
    request
  end

  def request
    @resp ||= JSON.parse(Net::HTTP.get_response(URI("http://#{@ip}:#{@port}/tasks.json")).body)
  end

  def tasks
    @resp.map(&:with_indifferent_access)
  end
end
