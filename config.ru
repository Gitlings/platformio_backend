require_relative 'platformio'

Rack::Handler::Thin.run Platformio.new
