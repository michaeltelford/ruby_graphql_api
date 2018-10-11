module Types
    class Comment < GraphQL::Schema::Object
        field :id, ID, null: false
        field :message, String, null: false
        field :post, Types::Post, null: false

        def self.create(post_id: SecureRandom.uuid)
            OpenStruct.new({
                id: SecureRandom.uuid,
                message: Faker::Matz.quote,
                post: OpenStruct.new({
                    id: post_id,
                    title: Faker::Book.title,
                    truncated_preview: "#{Faker::Matz.quote}...",
                    comments: []
                })
            })
        end
    end
end
