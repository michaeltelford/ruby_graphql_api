require "rack"
require_relative "helpers"

# class providing handlers for the GraphQL engine
class GraphQL
    include Rack::Utils

    # /graphql endpoint http handler
    def call(env)
        case env["REQUEST_METHOD"]
        when "GET"
            query_params = parse_nested_query env.fetch('QUERY_STRING', {})
            query = query_params['query']
            variables = query_params.fetch 'variables', {}
            handler query, variables
        when "POST"
            payload = env.fetch 'request.payload', {}
            query = payload['query']
            variables = payload.fetch 'variables', {}
            handler query, variables
        else
            respond 405, body: "Method not allowed"
        end
    end

private

    # generic handler which returns the graphql server response
    def handler(query, variables)
        return respond 404, body: "Missing query" unless query
        response = exec_schema query, variables
        respond 200, headers: CONTENT_TYPE_JSON, body: response
    end

    # query the graphql engine
    def exec_schema(query, variables)
        query
    end
end
