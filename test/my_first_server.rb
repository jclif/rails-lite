require 'active_support/core_ext'
require 'json'
require 'webrick'

server = WEBrick::HTTPServer.new :Port => 8080
root = "/"

server.mount_proc root do |req, res|
  res.body = req.path
  res.content_type = "text/text"
end

trap('INT') { server.shutdown }
server.start