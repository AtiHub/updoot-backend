FactoryBot.define do
  factory :comment do
    sequence(:title) { |n| "Title #{n}" }
    sequence(:content) { |n| "Content #{n}" }

    user { FactoryBot.create(:user) }
  end
end
