require 'active_support/core_ext'
require 'webrick'
require 'rails_lite'

server = WEBrick::HTTPServer.new :Port => 8080

class MyController < ControllerBase
  def go
    redirect_to("https://www.google.com")

    # after you have template rendering, uncomment:
#    render :show

    # after you have sessions going, uncomment:
#    session["count"] ||= 0
#    session["count"] += 1
#    render :counting_show
  end
end

server.mount_proc '/' do |req, res|
  MyController.new(req, res).go
end


server.start