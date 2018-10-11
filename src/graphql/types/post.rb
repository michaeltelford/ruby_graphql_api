module Types
    class Post < GraphQL::Schema::Object
        description "A blog post"
        field :id, ID, null: false
        field :title, String, null: false
        # Fields are queried in camel-case (this will be `truncatedPreview`).
        field :truncated_preview, String, null: false
        field :comments, [Types::Comment], null: true,
            description: "This post's comments, or null if this post has comments disabled."

        def self.create(id = SecureRandom.uuid)
            OpenStruct.new({
                id: id,
                title: Faker::Book.title,
                truncated_preview: "#{Faker::Matz.quote}...",
                comments: [
                    Types::Comment.create(post_id: id),
                    Types::Comment.create(post_id: id)
                ]
            })
        end
    end
end
