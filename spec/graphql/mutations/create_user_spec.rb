require 'rails_helper'

RSpec.describe('create_user', type: :request) do
  let(:query_string) do
    %(
      mutation($input: CreateUserInput!) {
        create_user(input: $input) {
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
        first_name: 'Atakan',
        last_name: 'Acar',
        auth_provider: {
          credentials: {
            email: 'selam@naber.com',
            password: '123456',
          },
        },
      },
    }
  end

  let(:invalid_inputs) do
    {
      input: {
        last_name: 'Acar',
        email: 'exp@exp.com',
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

  it 'create user' do
    data = result(inputs)['data']['create_user']['user']
    expect(data['id']).to(be)
    expect(data['first_name']).to(eq('Atakan'))
    expect(data['last_name']).to(eq('Acar'))
    expect(data['email']).to(eq('selam@naber.com'))
  end

  it 'increment user count by 1' do
    expect do
      result(inputs)
    end.to(change { User.count }.from(0).to(1))
  end

  it 'return failed' do
    expect(result(invalid_inputs)['errors']).to(be)
  end
end
