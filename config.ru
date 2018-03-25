require_relative 'platformio'

Faye::WebSocket.load_adapter('thin')
Rack::Handler::Thin.run Platformio.new, Port: 9292
