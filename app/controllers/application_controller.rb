class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :start_workers

  def start_workers

    if SuckerPunch::Queue.new(:broadcast).busy_size == 0
      SuckerPunch::Queue[:broadcast].async.perform
    end

    if SuckerPunch::Queue.new(:discovery).busy_size == 0
      SuckerPunch::Queue[:discovery].async.perform
    end

  end

end
