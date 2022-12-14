module Types
  class PostType < Types::BaseObject
    field :user, UserType, null: false, camelize: false
    field :community, CommunityType, null: false, camelize: false
    field :comments, [CommentType], null: false, camelize: false

    field :title, String, null: false, camelize: false
    field :content, String, null: false, camelize: false

    global_id_field :id

    implements GraphQL::Types::Relay::Node
  end
end
