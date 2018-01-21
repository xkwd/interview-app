FactoryBot.define do
  factory :interview do
    title { Faker::Dune.saying }
    description { Faker::Movie.quote }
    published true

    user
    country
  end
end
