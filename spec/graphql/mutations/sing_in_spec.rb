require 'rails_helper'

RSpec.describe('create_user', type: :request) do
  let(:user) { create(:user, email: 'selam@naber.com', password: '123456') }

  let(:query_string) do
    %(
      mutation($input: SignInInput!) {
        sign_in(input: $input) {
          token
          user {
            id
            first_name
            last_name
            email
            posts {
              id
              title
            }
          }
        }
      }
    )
  end

  let(:inputs) do
    {
      input: {
        credentials: {
          email: 'selam@naber.com',
          password: '123456',
        },
      },
    }
  end

  let(:invalid_inputs) do
    {
      input: {
        credentials: {
          email: 'selam@yanlis.com',
          password: '123456',
        },
      },
    }
  end

  let(:invalid_inputs_2) do
    {
      input: {
        credentials: {
          email: 'selam@naber.com',
          password: 'aaaaaa',
        },
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

  before do
    user
  end

  it 'sign in' do
    data = result(inputs)['data']['sign_in']
    expect(data['user']['id']).to(be)
    expect(data['user']['email']).to(eq('selam@naber.com'))

    expect(data['token']).to(be)
  end

  it 'wrong email' do
    expect(result(invalid_inputs)['data']['sign_in']).to(be_nil)
  end

  it 'wrong password' do
    expect(result(invalid_inputs_2)['data']['sign_in']).to(be_nil)
  end
end
