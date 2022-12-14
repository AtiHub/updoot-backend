require 'rails_helper'

RSpec.describe(Community, type: :model) do
  context 'Associations' do
    it { is_expected.to(belong_to(:creator)) }
    it { is_expected.to(have_many(:posts)) }
  end
end
