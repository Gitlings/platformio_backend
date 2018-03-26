# frozen_string_literal: true

require 'faye/websocket'
require 'eventmachine'

require_relative '../../platformio'

class ClientTests
  def self.run
    ClientTests.new.run
  end

  def run
    new_test
  end

  private

  def new_test
    Fiber.new do
      EM.run do
        setup_signals
        initialize_server
        new_client
      end
    end.resume
  end

  def initialize_server
    Faye::WebSocket.load_adapter('thin')
    Rack::Handler::Thin.run Platformio.new, Port: 9293, signals: false
  end

  def new_client
    ws = Faye::WebSocket::Client.new('ws://localhost:9293/')

    ws.on :open do |_event|
      p [:open]
      ws.send('Hello, world!')
    end

    ws.on :message do |event|
      p [:message, event.data]
    end

    ws.on :close do |event|
      p [:close, event.code, event.reason]
      ws = nil
    end

    ws
  end

  def stop_em
    puts 'Stopping the EventMachine...'
    EM.stop
  end

  def setup_signals
    @signal_queue ||= []

    %w[INT TERM].each do |signal|
      trap(signal) { @signal_queue.push signal }
    end
    # *nix only signals
    unless RUBY_PLATFORM.match?(/mswin|mingw/)
      %w[QUIT HUP USR1].each do |signal|
        trap(signal) { @signal_queue.push signal }
      end
    end

    @signal_timer ||= EM.add_periodic_timer(1) { handle_signals }
  end

  def handle_signals
    signal = @signal_queue.shift
    case signal
    when 'INT'
      stop_em
    when 'TERM', 'QUIT'
      stop_em
    when 'HUP'
    # Placeholder (Thin, for instance, restarts here).
    when 'USR1'
    # Placeholder (Thin, for instance, reopens logs here).
    else
      raise 'Unknown signal ' + signal unless signal.nil?
    end
    EM.next_tick { handle_signals } unless @signal_queue.empty?
  end
end
