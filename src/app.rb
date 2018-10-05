require "rack"
require "rack/json_parser"
require_relative "helpers"
require_relative "graphql"

# Init generic handlers for outside of /graphql.
not_found = Proc.new { |env| respond 404, body: "Not found" }
health = Proc.new { |env| respond 204 }

# Rack app - entry point to the graphql API.
App = Rack::Builder.new do
    # map routes to handlers
    map('/') { run not_found }
    map('/health') { run health }
    map('/healthcheck') { run health }
    map('/graphql') do
        # Use middleware components.
        use Rack::Reloader, 0
        use Rack::JSONParser

        run GraphQL.new
    end
end.to_app
