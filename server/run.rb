require 'webrick'
require_relative './router/router.rb'
require_relative './router/routes.rb'
Dir[File.join(File.dirname(__FILE__), 'controllers', '*.rb')].each {|file| require file }
include Routes

router = Router.new
create_routes(router)
server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  router.run(req, res)
end

trap('INT') { server.shutdown }
server.start
