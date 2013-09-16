require 'erb'
require 'debugger'# ; debugger
require 'active_support/core_ext'
require_relative 'params'
require_relative 'session'

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @already_built_response = false
    session
    @params = Params.new(req, route_params)
  end

  def session
    @session ||= Session.new(@req)
  end

  def already_rendered?
  end

  def redirect_to(url)
    @res.status = 302
    @res.header["location"] = url
    @already_built_response = true
    session.store_session(@res)
  end

  def render_content(content, type)
    @res.body = content
    @res.content_type = type
    @already_built_response = true
    session.store_session(@res)
  end

  def render(template_name)
    controller_name = self.class.to_s
    template_path = "#{Dir.pwd}/views/#{controller_name.underscore}/#{template_name}.html.erb"
    erb_template = IO.read(template_path)

    render_content(ERB.new(erb_template).result(binding), "text/text")
  end

  def invoke_action(name)
  end
end
