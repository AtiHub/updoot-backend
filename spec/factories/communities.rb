FactoryBot.define do
  factory :community do
    sequence(:name) { |n| "Community #{n}" }
    description { 'Creative description!' }

    creator { FactoryBot.create(:user) }
  end
end
