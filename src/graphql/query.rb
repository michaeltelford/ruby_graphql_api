require "ostruct"
require_relative "post_type"
# require_relative "types/comment_type"

class QueryType < GraphQL::Schema::Object
    description "The query root of this schema"

    field :post, PostType, null: true do
        description "Find a post by ID"
        # argument :id, ID, required: true
    end

    def post #(id:)
        OpenStruct.new({
            id: 1,
            title: "Test Post",
            truncated_preview: "Here is my test post, hope you enjoy!",
            # comments: []
        })
    end
end
