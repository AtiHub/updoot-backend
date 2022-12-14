require 'rails_helper'

RSpec.describe('GraphqlController', type: :request) do
  describe '#execute' do
    let(:user) { create(:user) }

    let(:header) do
      {
        'ACCEPT': 'application/json',
        'Content-Type': 'application/json',
        'TOKEN': generate_token(user),
      }
    end

    def generate_token(user)
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      crypt.encrypt_and_sign("user-id:#{user.id}")
    end

    let(:query_string) do
      %(
        query {
          node(id: "#{user.to_gid_param}") {
            ... on User {
              id
            }
          }
        }
      )
    end

    let(:params) do
      {
        query: query_string,
      }
    end

    def post_request
      post('/graphql', params: params.to_json, headers: header)
    end

    context 'find current_user' do
      it 'success' do
        post_request

        expect(json['data']['node']['id']).to(be)
      end

      it 'fail' do
        header[:TOKEN] = 'selamnaber'
        post_request

        expect(json['errors']).to(be)
      end
    end
  end
end
