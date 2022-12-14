module Types
  class AuthProviderCredentialsInput < BaseInputObject
    argument :email, String, required: true, camelize: false
    argument :password, String, required: true, camelize: false
  end
end
