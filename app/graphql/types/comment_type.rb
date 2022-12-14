module Types
  class CommentType < Types::BaseObject
    field :user, UserType, null: false, camelize: false
    field :post, PostType, null: false, camelize: false

    field :title, String, null: false, camelize: false
    field :content, String, null: false, camelize: false

    global_id_field :id

    implements GraphQL::Types::Relay::Node
  end
end
