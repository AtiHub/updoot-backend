require 'rails_helper'

RSpec.describe(User, type: :model) do
  context 'Associations' do
    it { is_expected.to(have_many(:owned_communities)) }
    it { is_expected.to(have_many(:posts)) }
    it { is_expected.to(have_many(:comments)) }
  end

  context 'Validations' do
    it { is_expected.to(validate_presence_of(:first_name)) }
    it { is_expected.to(validate_presence_of(:last_name)) }
    it { is_expected.to(validate_presence_of(:email)) }
    it { is_expected.to(validate_uniqueness_of(:email)) }
  end
end
