require 'minitest/autorun'
require 'rack'
require 'rack/test'
require 'oj'
require_relative '../src/app'

# any test helper methods go below...

# takes a Hash, converts to json and sets rack.input (request.body)
def rack_input(data)
  json = Oj.dump data
  h = { "rack.input" => json }
  io = StringIO.new
  io.puts Oj.dump(h)
  Rack::Lint::InputWrapper.new io
end
