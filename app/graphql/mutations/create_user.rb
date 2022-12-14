module Mutations
  class CreateUser < BaseMutation
    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: true, camelize: false
    end

    argument :first_name, String, required: true, camelize: false
    argument :last_name, String, required: true, camelize: false
    argument :auth_provider, AuthProviderSignupData, required: true, camelize: false

    field :user, Types::UserType

    def resolve(**args)
      user = User.create!(
        first_name: args[:first_name],
        last_name: args[:last_name],
        email: args.dig(:auth_provider, :credentials, :email),
        password: args.dig(:auth_provider, :credentials, :password),
      )

      {
        user: user,
      }
    end
  end
end
