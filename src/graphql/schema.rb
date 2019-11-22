require_relative "types/types"
require_relative "query"
require_relative "mutations"

class Schema < GraphQL::Schema
    query Query
    mutation Mutations
end
