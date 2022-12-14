require 'rails_helper'

RSpec.describe('create_user', type: :request) do
  let(:user) { create(:user) }
  let(:community) { create(:community, creator: user) }
  let(:post) { create(:post, user: user, community: community) }
  let(:comment) { create(:comment, user: user, post: post) }

  let(:query_string) do
    %(
      mutation($input: CreatePostInput!) {
        create_post(input: $input) {
          post {
            id
            title
            content
            user {
              id
            }
            community {
              id
            }
          }
          errors
        }
      }
    )
  end

  let(:inputs) do
    {
      input: {
        title: 'mükkemmel title',
        content: 'çok kaliteli content',
        user_id: user.to_gid_param,
        community_id: community.to_gid_param,
      },
    }
  end

  let(:invalid_inputs) do
    {
      input: {
        title: 'mükkemmel title',
        content: '',
        user_id: user.to_gid_param,
        community_id: community.to_gid_param,
      },
    }
  end

  def result(variables)
    UpdootBackendSchema.execute(
      query_string,
      context: {},
      variables: variables
    )
  end

  it 'create post' do
    data = result(inputs)['data']['create_post']['post']
    expect(data['id']).to(be)
    expect(data['title']).to(eq('mükkemmel title'))
    expect(data['content']).to(eq('çok kaliteli content'))
    expect(data['user']['id']).to(eq(user.to_gid_param))
    expect(data['community']['id']).to(eq(community.to_gid_param))
  end

  it 'increment post count by 1' do
    expect do
      result(inputs)
    end.to(change { Post.count }.from(0).to(1))
  end

  it 'return error' do
    data = result(invalid_inputs)['data']['create_post']
    expect(data['errors']).to(be)
  end
end
