FactoryBot.define do
  factory :note do
    text { Faker::Lorem.sentence }
    association :user
  end
end
