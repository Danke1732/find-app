FactoryBot.define do
  factory :profile do
    hobby { Faker::Lorem.characters(number: 50) }
    favorite_word { Faker::Lorem.characters(number: 50) }
    introduction { Faker::Lorem.characters(number: 50) }
    association :user
  end
end
