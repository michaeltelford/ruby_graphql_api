module Types
    class Comment < GraphQL::Schema::Object
        field :id, ID, null: false
        field :post, Types::Post, null: false
    end
end
