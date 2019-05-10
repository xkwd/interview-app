FactoryBot.define do
  factory :rating do
    positive { false }
    user { nil }
    comment { nil }
  end
end
