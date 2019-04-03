FactoryBot.define do
  factory :interview do
    title { Faker::Books::Dune.saying }
    description { Faker::Lorem.paragraphs(rand(2...3)).join }
    published true

    user
    country
  end
end
