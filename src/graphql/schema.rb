require_relative "query"

class Schema < GraphQL::Schema
    query QueryType
end
