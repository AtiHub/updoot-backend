module Types
  class CommunityType < Types::BaseObject
    field :creator, UserType, null: false, camelize: false
    field :posts, [PostType], null: false, camelize: false

    field :name, String, null: false, camelize: false
    field :description, String, null: false, camelize: false

    global_id_field :id

    implements GraphQL::Types::Relay::Node
  end
end
