require_relative "types/types"
require_relative "query"
# require_relative "mutation"

class Schema < GraphQL::Schema
    query Query
    # mutation Mutation
end
