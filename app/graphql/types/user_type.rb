module Types
  class UserType < Types::BaseObject
    field :owned_communities, [CommunityType], null: false, camelize: false
    field :posts, [PostType], null: false, camelize: false
    field :comments, [CommentType], null: false, camelize: false

    field :first_name, String, null: false, camelize: false
    field :last_name, String, null: false, camelize: false
    field :email, String, null: false, camelize: false

    global_id_field :id

    implements GraphQL::Types::Relay::Node
  end
end
