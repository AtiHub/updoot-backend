require 'rails_helper'

RSpec.describe('users', type: :request) do
  let(:query_string) do
    %(
      query {
        users {
          totalCount
          pageInfo {
            startCursor
            endCursor
            hasPreviousPage
            hasNextPage
          }
          edges {
            cursor
            node {
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
      }
    )
  end

  let(:query_string_2) do
    %(
      query {
        node(id: user) {
          totalCount
          pageInfo {
            startCursor
            endCursor
            hasPreviousPage
            hasNextPage
          }
          edges {
            cursor
            node {
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

  it 'return users' do
    pp result
    data = result['data']['users']['edges']

    expect(data[0]['node']['id']).to(eq(user.id))
    expect(data[0]['node']['first_name']).to(eq(user.first_name))
    expect(data[0]['node']['last_name']).to(eq(user.last_name))
    expect(data[0]['node']['email']).to(eq(user.email))
    expect(data[0]['node']['owned_communities'][0]['id']).to(eq(community.id))
    expect(data[0]['node']['posts'][0]['id']).to(eq(post.id))
    expect(data[0]['node']['comments'][0]['id']).to(eq(comment.id))
  end
end
