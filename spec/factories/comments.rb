FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.characters(number: 50) }
    association :user
    association :article
  end
end
