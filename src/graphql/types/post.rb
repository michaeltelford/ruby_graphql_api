module Types
    class Post < GraphQL::Schema::Object
        description "A blog post"
        field :id, ID, null: false
        field :title, String, null: false
        # Fields are queried in camel-case (this will be `truncatedPreview`).
        field :truncated_preview, String, null: false
        field :comments, [Types::Comment], null: true,
            description: "This post's comments, or null if this post has comments disabled."

        def self.create(id = 1)
            OpenStruct.new({
                id: id,
                title: "Test Post",
                truncated_preview: "Here is my test post, hope you enjoy!",
                comments: [
                    Types::Comment.create,
                    Types::Comment.create,
                    Types::Comment.create
                ]
            })
        end
    end
end
