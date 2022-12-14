require 'rails_helper'

RSpec.describe('fetch_community', type: :request) do
  let(:query_string) do
    %(
      query {
        node(id: "#{community.to_gid_param}") {
          ... on Community {
            id
            name
            description
            creator {
              id
            }
            posts {
              id
              comments {
                id
              }
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

  it 'return community' do
    data = result['data']['node']

    expect(data['id']).to(eq(community.to_gid_param))
    expect(data['name']).to(eq(community.name))
    expect(data['description']).to(eq(community.description))
    expect(data['creator']['id']).to(eq(user.to_gid_param))
    expect(data['posts'][0]['id']).to(eq(post.to_gid_param))
    expect(data['posts'][0]['comments'][0]['id']).to(eq(comment.to_gid_param))
  end
end
