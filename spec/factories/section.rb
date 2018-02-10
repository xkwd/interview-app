FactoryBot.define do
  factory :section do
    name { Faker::Job.field }
    description { Faker::Lorem.paragraphs.join }
  end
end
