require_relative "helpers"

# class providing handlers for the GraphQL engine
class GraphQL
    def call(env)
        payload = env['request.payload']
        respond 200, body: payload['query']
    end
end
