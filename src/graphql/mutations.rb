class Mutations < GraphQL::Schema::Object
    description "The mutation root of this schema"

    # createPost(...)
    field :create_post, Types::Post, null: true do
        description "Create a post"
        argument :post, Types::Post, required: true
    end

    def post(post:)
        post
    end
end
