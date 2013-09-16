require 'erb'
require_relative 'params'
require_relative 'session'

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @already_built_response = false
  end

  def session
  end

  def already_rendered?
  end

  def redirect_to(url)
    @res.status = 302
    @res.header["location"] = url
    @already_built_response = true
  end

  def render_content(content, type)
    @res.body = content
    @res.content_type = type
    @already_built_response = true
  end

  def render(template_name)
  end

  def invoke_action(name)
  end
end
