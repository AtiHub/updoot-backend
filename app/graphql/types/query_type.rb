module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, UserConnectionType, null: false, connection: true, description: 'All users'

    def users
      User.all
    end

    field :fetch_user, Types::UserType, camelize: false, description: 'Fetch user' do
      argument :id, ID, required: true, camelize: false
    end

    def fetch_user(id:)
      User.find(id)
    end

    field :fetch_community, Types::CommunityType, camelize: false, description: 'Fetch community' do
      argument :id, ID, required: true, camelize: false
    end

    def fetch_community(id:)
      Community.find(id)
    end

    field :fetch_post, Types::PostType, camelize: false, description: 'Fetch post' do
      argument :id, ID, required: true, camelize: false
    end

    def fetch_post(id:)
      Post.find(id)
    end
  end
end
