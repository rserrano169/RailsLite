require_relative '../controller_base/controller_base.rb'
require_relative 'route.rb'

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  def add_route(pattern, method, controller_class, action_name)
    @routes << Route.new(pattern, method, controller_class, action_name)
  end

  def draw(&proc)
    instance_eval(&proc)
  end

  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      add_route(pattern, http_method, controller_class, action_name)
    end
  end

  def match(req)
    return @routes.find {|r| r.matches?(req)}
  end

  def run(req, res)
    match(req) ? match(req).run(req, res) : res.status = 404
  end
end
