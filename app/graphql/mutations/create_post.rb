module Mutations
  class CreatePost < BaseMutation
    argument :title, String, required: true, camelize: false
    argument :content, String, required: true, camelize: false
    argument :community_id, ID, required: true, camelize: false, loads: Types::CommunityType
    argument :user_id, ID, required: true, camelize: false, loads: Types::UserType

    field :post, Types::PostType
    field :errors, [String]

    def resolve(user:, community:, **args)
      post = user.posts.build(
        title: args[:title],
        content: args[:content],
        community: community,
      )

      if post.save
        {
          post: post,
          errors: [],
        }
      else
        {
          post: nil,
          errors: post.errors.full_messages,
        }
      end
    end
  end
end
