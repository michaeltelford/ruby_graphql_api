class Query < GraphQL::Schema::Object
    description "The query root of this schema"

    field :post, Types::Post, null: true do
        description "Find a post by ID"
        argument :id, ID, required: true
    end

    def post(id:)
        OpenStruct.new({
            id: id,
            title: "Test Post",
            truncated_preview: "Here is my test post, hope you enjoy!",
            comments: []
        })
    end
end
