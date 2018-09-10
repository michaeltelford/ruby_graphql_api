require "rack"
require "rack/json_parser"
require_relative "helpers"
require_relative "app"

# init generic handlers for outside of /graphql
not_found = Proc.new { |env| respond 404, body: "Not found" }
health = Proc.new { |env| respond 204 }

# map routes to handlers
map('/') { run not_found }
map('/health') { run health }
map('/healthcheck') { run health }
map('/graphql') do
    # use middleware components
    use Rack::Reloader, 0
    use Rack::JSONParser

    run GraphQL.new
end
