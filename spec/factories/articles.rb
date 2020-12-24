FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.sentence }
    association :user
    association :category

    after(:build) do |article|
      article.image.attach(io: File.open('public/images/test-image.jpg'), filename: 'test-image.jpg')
    end
  end

  factory :article_test, class: Article do
    title { 'test' }
    text { 'testtest' }
    category_id { 3 }
  end
end
