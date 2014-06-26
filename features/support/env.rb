lib = File.expand_path("../../../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "rack/test"
require "sinatra/base"
require "midas"
require "minitest"
require "minitest/unit"

World(MiniTest::Assertions)

module Midas
  module TestHelpers
    def mock_app(&block)
      @app = Sinatra.new(Sinatra::Base) do
        class_eval(&block)
      end
    end

    def app
      @app ||= Class.new(Sinatra::Base)
    end
  end
end

World(Rack::Test::Methods)
World(Midas::TestHelpers)
