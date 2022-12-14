module Mutations
  class SignIn < BaseMutation
    argument :credentials, Types::AuthProviderCredentialsInput, required: true, camelize: false

    field :token, String, null: true, camelize: false
    field :user, Types::UserType, null: true, camelize: false

    def resolve(credentials:)
      user = User.find_by(email: credentials[:email])

      return unless user
      return unless user.authenticate(credentials[:password])

      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{user.id}")

      {
        token: token,
        user: user,
      }
    end
  end
end
