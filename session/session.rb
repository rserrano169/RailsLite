require 'json'
require 'webrick'

class Session
  def initialize(req)
    cookie = req.cookies.find { |c| c.name == '_rails_lite_app' }
    cookie ? @cookie_val = JSON.parse(cookie.value) : @cookie_val = {}
  end

  def [](key)
    @cookie_val[key]
  end

  def []=(key, val)
    @cookie_val[key] = val

    val
  end

  def store_session(res)
    cookie = WEBrick::Cookie.new('_rails_lite_app', @cookie_val.to_json)
    res.cookies << cookie
  end
end
