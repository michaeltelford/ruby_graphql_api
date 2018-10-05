class PostType < GraphQL::Schema::Object
    description "A blog post"
    field :id, ID, null: false
    field :title, String, null: false
    # Fields are queried in camel-case (this will be `truncatedPreview`).
    field :truncated_preview, String, null: false
    # field :comments, [CommentType], null: true,
    #     description: "This post's comments, or null if this post has comments disabled."
end
