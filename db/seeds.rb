# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


10.times do
  Country.create(
    name: Faker::Address.country
  )
end

10.times do
  City.create(
    name: Faker::Address.city,
    country_id: Faker::Number.between(1, 10)
  )
end

5.times do
  Section.create(
    name: Faker::Job.field
  )
end

5.times do
  User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

(1..5).each do |i|
  Interview.create(
    title: Faker::Dune.saying,
    description: Faker::Movie.quote,
    user_id: i
  )
end


(1..5).each do |i|
  Answer.create(
    content: Faker::Lorem.paragraphs.join(),
    interview_id: 1,
    section_id: i
  )
  Answer.create(
    content: Faker::Lorem.paragraphs.join(),
    interview_id: 2,
    section_id: i
  )
  Answer.create(
    content: Faker::Lorem.paragraphs.join(),
    interview_id: 3,
    section_id: i
  )
  Answer.create(
    content: Faker::Lorem.paragraphs.join(),
    interview_id: 4,
    section_id: i
  )
  Answer.create(
    content: Faker::Lorem.paragraphs.join(),
    interview_id: 5,
    section_id: i
  )
end
