module Types
    class Comment < GraphQL::Schema::Object
        field :id, ID, null: false
        field :post, Types::Post, null: false

        def self.create
            OpenStruct.new({
                id: 123,
                post: OpenStruct.new({
                    id: 1000,
                    title: "VR Blogger",
                    truncated_preview: "Virtual Reality Blogger Yo!",
                    comments: []
                })
            })
        end
    end
end
