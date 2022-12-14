class BaseEdge < GraphQL::Types::Relay::BaseEdge
  node_type(Types::UserType)
end

class Types::UserConnectionType < GraphQL::Types::Relay::BaseConnection
  graphql_name 'UserConnectionType'
  edge_type(BaseEdge)

  field :total_count, Integer, null: true
  def total_count
    object.items.count
  end
end
