require 'json'
require 'webrick'
require 'debugger'

class Session
  def initialize(req)
    @req = req
    cookie = @req.cookies.select {|cookie| cookie.name == "_rails_lite_app" }.first
    @cookie = cookie ? JSON.parse(cookie.value) : {}
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  def store_session(res)
    jsonized_content = @cookie.to_json
    res.cookies << WEBrick::Cookie.new("_rails_lite_app", jsonized_content)
  end
end