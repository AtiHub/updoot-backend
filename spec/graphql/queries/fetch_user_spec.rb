require 'rails_helper'

RSpec.describe('fetch_user', type: :request) do
  let(:query_string) do
    %(
      query {
        node(id: "#{user.to_gid_param}") {
          ... on User {
            id
            first_name
            last_name
            email
            owned_communities {
              id
            }
            posts {
              id
            }
            comments {
              id
            }
          }
        }
      }
    )
  end

  let(:variables) { {} }
  let(:result) do
    UpdootBackendSchema.execute(
      query_string,
      context: {},
      variables: variables
    )
  end

  let(:user) { create(:user) }
  let(:community) { create(:community, creator: user) }
  let(:post) { create(:post, user: user, community: community) }
  let(:comment) { create(:comment, user: user, post: post) }

  before do
    user
    community
    post
    comment
  end

  it 'return user' do
    data = result['data']['node']

    expect(data['id']).to(eq(user.to_gid_param))
    expect(data['first_name']).to(eq(user.first_name))
    expect(data['last_name']).to(eq(user.last_name))
    expect(data['email']).to(eq(user.email))
    expect(data['owned_communities'][0]['id']).to(eq(community.to_gid_param))
    expect(data['posts'][0]['id']).to(eq(post.to_gid_param))
    expect(data['comments'][0]['id']).to(eq(comment.to_gid_param))
  end
end
