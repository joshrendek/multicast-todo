require 'net/http'
class ServersController < ApplicationController
  def show
    @server = Server.find(params[:id])

    @tasks = JSON.parse(Net::HTTP.get_response(URI("http://#{@server.ip}:#{@server.port}/tasks.json")).body)
    @tasks = @tasks.map(&:with_indifferent_access)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server }
    end
  end

end
