FactoryBot.define do
    factory :book do
      title { Faker::Book.title }
      author { Faker::Book.author }
      published_year { Faker::Number.between(from: 1900, to: Time.now.year) }
    end
  end
  