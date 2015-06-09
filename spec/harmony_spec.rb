require 'webrick'
require_relative '../config/controller_base/controller_base.rb'
require_relative '../config/router/router.rb'
require_relative '../config/router/route.rb'

describe "working together" do
  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }

  before(:all) do
    class TestController < ControllerBase
      def route_render
        render_content("testing", "text/html")
      end

      def route_does_params
        render_content("got ##{ params["id"] }", "text/text")
      end

      def update_session
        session[:token] = "testing"
        render_content("hi", "text/html")
      end
    end
  end
  after(:all) { Object.send(:remove_const, "TestController") }

  describe "routes and params" do
    it "route instantiates controller and calls invoke action" do
      route = Route.new(Regexp.new("^/statuses/(?<id>\\d+)$"), :get, TestController, :route_render)
      allow(req).to receive(:path) { "/statuses/1" }
      allow(req).to receive(:request_method) { :get }
      route.run(req, res)
      expect(res.body).to eq("testing")
    end

    it "route adds to params" do
      route = Route.new(Regexp.new("^/statuses/(?<id>\\d+)$"), :get, TestController, :route_does_params)
      allow(req).to receive(:path) { "/statuses/1" }
      allow(req).to receive(:request_method) { :get }
      route.run(req, res)
      expect(res.body).to eq("got #1")
    end
  end

  describe "controller sessions" do
    let(:test_controller) { TestController.new(req, res) }

    it "exposes a session via the session method" do
      expect(test_controller.session).to be_instance_of(Session)
    end

    it "saves the session after rendering content" do
      test_controller.update_session
      # Currently broken when flash is used. Need to store flash in the cookie
      # or change this spec.
      expect(res.cookies.count).to eq(1)
      expect(JSON.parse(res.cookies[0].value)["token"]).to eq("testing")
    end
  end
end
