module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser, camelize: false
    field :sign_in, mutation: Mutations::SignIn, camelize: false

    field :create_post, mutation: Mutations::CreatePost, camelize: false
  end
end
