require 'rails_helper'

RSpec.describe('fetch_post', type: :request) do
  let(:query_string) do
    %(
      query {
        node(id: "#{post.to_gid_param}") {
          ... on Post {
            id
            title
            content
            user {
              id
            }
            community {
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

  it 'return post' do
    data = result['data']['node']

    expect(data['id']).to(eq(post.to_gid_param))
    expect(data['title']).to(eq(post.title))
    expect(data['content']).to(eq(post.content))
    expect(data['user']['id']).to(eq(user.to_gid_param))
    expect(data['community']['id']).to(eq(community.to_gid_param))
    expect(data['comments'][0]['id']).to(eq(comment.to_gid_param))
  end
end
