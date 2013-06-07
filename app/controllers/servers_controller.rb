require 'net/http'
class ServersController < ApplicationController
  def show
    @server = Server.find(params[:id])

    @tasks = RemoteServerTasks.new(@server.ip, @server.port).tasks

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server }
    end
  end

end
