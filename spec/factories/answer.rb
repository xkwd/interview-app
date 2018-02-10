FactoryBot.define do
  factory :answer do
    content { Faker::Lorem.paragraphs(rand(10...25)).join }

    interview
    section
  end
end
