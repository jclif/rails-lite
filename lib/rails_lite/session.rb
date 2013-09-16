require 'json'
require 'webrick'

class Session
  def initialize(req)
    @req = req
    cookie = @req.cookies.select {|hash| hash.key == "_rails_lite_app" }.first
    @cookie = cookie ? JSON.parse (cookie) : {}
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  def store_session(res)
    jsonized_cookie_hash = {"_rails_lite_app" => @cookie.to_json}
    res.cookies << jsonized_cookie_hash
  end
end
