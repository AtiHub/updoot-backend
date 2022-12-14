class UpdootBackendSchema < GraphQL::Schema
  default_max_page_size 50

  mutation(Types::MutationType)
  query(Types::QueryType)

  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  use GraphQL::Dataloader

  # GraphQL-Ruby calls this when something goes wrong while running a query:
  def self.type_error(err, context)
    # if err.is_a?(GraphQL::InvalidNullError)
    #   # report to your bug tracker here
    #   return nil
    # end
    super
  end

  def self.resolve_type(type, obj, ctx)
    case obj
    when User
      Types::UserType
    when Post
      Types::PostType
    when Comment
      Types::CommentType
    when Community
      Types::CommunityType
    else
      raise("Unexpected object: #{obj}")
    end
  end

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, query_ctx)
    # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
    object.to_gid_param
  end

  # Given a string UUID, find the object
  def self.object_from_id(global_id, query_ctx)
    # For example, use Rails' GlobalID library (https://github.com/rails/globalid):
    GlobalID.find(global_id)
  end
end
