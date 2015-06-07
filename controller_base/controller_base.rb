require 'active_support'
require 'active_support/core_ext'
require 'erb'
require 'active_support/inflector'
require_relative '../params/params.rb'
require_relative '../session/session.rb'

class ControllerBase
  attr_reader :req, :res

  def initialize(req, res, route_params = {})
    @req, @res = req, res
    @params = Params.new(req, route_params)
    @already_built_response = false
  end

  def already_built_response?
    @already_built_response
  end

  def redirect_to(url)
    raise "response already built" if already_built_response?

    @res.header["location"] = url
    @res.status = 302

    @already_built_response = true

    session.store_session(@res)

    nil
  end

  def render_content(content, content_type)
    raise "response already built" if already_built_response?

    @res.content_type = content_type
    @res.body = content

    @already_built_response = true

    session.store_session(@res)

    nil
  end

  def render(template_name)
    controller_name = self.class.name.underscore.chomp("_controller")
    dir_path = File.dirname(__FILE__)
    template_file_name = File.join(
      dir_path,
      "..",
      "views",
      controller_name,
      "#{template_name}.html.erb"
    )
    template_code = File.read(template_file_name)
    content = ERB.new(template_code).result(binding)
    render_content(content, "text/html")
  end

  def session
    @session ||= Session.new(@req)
  end

  def invoke_action(name)
    self.send(name)
    render(name) unless already_built_response?

    nil
  end
end
