require "rack"
require "graphql" # required here and not in the graphql dir *.rb files.
require_relative "helpers"
require_relative "graphql/schema"

# Class providing handlers for the GraphQL engine.
class GraphHandler
    include Rack::Utils

    # /graphql endpoint http handler.
    # The query and variables come from the URL or the body;
    # once retrieved, they are passed to a generic handler for validation and
    # then given to the graphql engine for processing.
    def call(env)
        begin
            case env["REQUEST_METHOD"]
            when "GET"
                query_params = parse_nested_query env.fetch('QUERY_STRING', {})
                query = query_params.fetch 'query', ''
                variables = query_params.fetch 'variables', {}
                handler query, variables
            when "POST"
                payload = env.fetch 'request.payload', {}
                query = payload.fetch 'query', ''
                variables = payload.fetch 'variables', {}
                handler query, variables
            else
                respond 405, body: "Method not allowed"
            end
        rescue => ex
            Log.error "#{ex.class} - #{ex.message}"
            respond 500, body: "Internal server error"
        end
    end

private

    # Generic handler which returns the graphql server response.
    def handler(query, variables)
        return respond 400, body: "Missing query" if query.empty?
        response = exec_schema query, variables
        respond 200, headers: CONTENT_TYPE_JSON, body: response.to_h
    end

    # Query the graphql schema and return the GraphQL::Query::Result.
    def exec_schema(query, variables)
        Schema.execute(query)
    end
end
