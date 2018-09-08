require_relative "helpers"

# class providing handlers for the GraphQL engine
class GraphQL
    # /graphql endpoint http handler
    def call(env)
        case env["REQUEST_METHOD"]
        when "GET"
            respond 200, headers: {}, body: env["PATH_INFO"]
        when "POST"
            payload = env['request.payload'] || {}
            response = query payload['query'], payload['variables']
            respond 200, body: response
        else
            respond 405, headers: {}, body: "Method not allowed"
        end
    end

    # query the graphql engine
    def query(query, variables={})
        query
    end
end