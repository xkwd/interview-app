Country.delete_all
10.times do
  Country.create!(
    name: Faker::Address.country
  )
end

City.delete_all
10.times do
  City.create!(
    name: Faker::Address.city,
    country_id: Country.ids.sample
  )
end

Section.delete_all
5.times do
  Section.create!(
    name: Faker::Job.field
  )
end

User.delete_all
5.times do
  User.create!(
    email: Faker::Internet.email,
    password: "T3RyWrKcD9K"
  )
end

Interview.delete_all
(1..5).each do |i|
  Interview.create!(
    title: Faker::Dune.saying,
    description: Faker::Movie.quote,
    user_id: User.ids[i-1]
  )
end

Answer.delete_all
(1..5).each do |i|
  Answer.create!(
    content: Faker::Lorem.paragraphs.join(),
    interview_id: Interview.ids[0],
    section_id: Section.ids[i-1]
  )
  Answer.create!(
    content: Faker::Lorem.paragraphs.join(),
    interview_id: Interview.ids[1],
    section_id: Section.ids[i-1]
  )
  Answer.create!(
    content: Faker::Lorem.paragraphs.join(),
    interview_id: Interview.ids[2],
    section_id: Section.ids[i-1]
  )
  Answer.create!(
    content: Faker::Lorem.paragraphs.join(),
    interview_id: Interview.ids[3],
    section_id: Section.ids[i-1]
  )
  Answer.create!(
    content: Faker::Lorem.paragraphs.join(),
    interview_id: Interview.ids[4],
    section_id: Section.ids[i-1]
  )
end
