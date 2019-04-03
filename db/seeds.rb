Rails.logger = Logger.new(STDOUT)

country_cities_list = { "Australia" => ["Melbourne"],
                       "Austria" => ["Vienna"],
                       "Belgium" => ["Brussels"],
                       "Canada" => ["Toronto", "Vancouver", "Montreal"],
                       "China" => ["Beijing", "Shanghai"],
                       "Cyprus" => ["Nicosia", "Larnaca"],
                       "Czech Republic" => ["Prague", "Brno"],
                       "Denmark" => ["Copenhagen"],
                       "Finland" => ["Helsinki"],
                       "France" => ["Paris", "Lyon"],
                       "Germany" => ["Berlin", "Munich", "Dusseldorf"],
                       "Greece" => ["Athens"],
                       "Hungary" => ["Budapest"],
                       "Ireland" => ["Dublin"],
                       "Italy" => ["Milano"],
                       "Israel" => ["Tel Aviv", "Jerusalem"],
                       "Japan" => ["Tokyo"],
                       "Latvia" => ["Riga"],
                       "Lithuania" => ["Vilnius"],
                       "Netherlands" => ["Amsterdam", "Eindhoven"],
                       "New Zealand" => ["Auckland", "Wellington"],
                       "Norway" => ["Oslo"],
                       "Poland" => ["Krakow", "Wroclaw", "Warsaw", "Poznan"],
                       "Portugal" => ["Lisbon", "Porto"],
                       "Slovakia" => ["Bratislava", "Kosice"],
                       "Slovenia" => ["Ljubljana"],
                       "Spain" => ["Madrid", "Barcelona"],
                       "Sweden" => ["Stockholm", "Gothenburg", "Malmo"],
                       "Switzerland" => ["Zurich", "Geneva"],
                       "United States" => ["New York", "Los Angeles"] }

Rails.logger.info "Creating countries..."

Country.delete_all
country_cities_list.each_key do |country|
  Country.create!(
    name: country
  )
end

Rails.logger.info "Creating cities..."

City.delete_all
country_cities_list.each do |k, v|
  v.each do |city|
    City.create!(
      name: city,
      country_id: Country.find_by(name: k).id
    )
  end
end

Rails.logger.info "Creating sections..."

Section.delete_all
5.times do
  Section.create!(
    name: Faker::Job.field,
    description: Faker::Lorem.paragraphs.join
  )
end

Rails.logger.info "Creating users..."

User.delete_all
5.times do
  User.create!(
    email: Faker::Internet.email,
    name: Faker::Name.name,
    password: "T3RyWrKcD9K"
  )
end

Rails.logger.info "Creating interviews..."

Interview.delete_all
User.ids.each do |id|
  Interview.create!(
    title: Faker::Books::Dune.saying,
    description: Faker::Lorem.paragraphs(rand(2...3)).join,
    user_id: id,
    country_id: Country.ids.sample,
    published: true
  )
end

Rails.logger.info "Creating answers..."

Answer.delete_all
Section.ids.each do |id|
  Answer.create!(
    content: Faker::Lorem.paragraphs(rand(10...25)).join,
    interview_id: Interview.ids[0],
    section_id: id
  )
  Answer.create!(
    content: Faker::Lorem.paragraphs(rand(10...25)).join,
    interview_id: Interview.ids[1],
    section_id: id
  )
  Answer.create!(
    content: Faker::Lorem.paragraphs(rand(10...25)).join,
    interview_id: Interview.ids[2],
    section_id: id
  )
  Answer.create!(
    content: Faker::Lorem.paragraphs(rand(10...25)).join,
    interview_id: Interview.ids[3],
    section_id: id
  )
  Answer.create!(
    content: Faker::Lorem.paragraphs(rand(10...25)).join,
    interview_id: Interview.ids[4],
    section_id: id
  )
end

Rails.logger.info "Creating comments..."

Comment.delete_all
Interview.all.each do |interview|
  interview_comment1 = interview.comments.create!(
    body: Faker::Lorem.paragraphs(rand(1...3)).join,
    commenter_name: Faker::Name.name,
    commenter_email: Faker::Internet.email
  )
  nested_comment1 = interview_comment1.comments.create!(
    body: Faker::Lorem.paragraphs(rand(1...7)).join,
    commenter_name: Faker::Name.name,
    commenter_email: Faker::Internet.email
  )
  nested_comment1.comments.create!(
    body: Faker::Lorem.paragraphs(rand(1...5)).join,
    commenter_name: Faker::Name.name,
    commenter_email: Faker::Internet.email
  )
  interview.comments.create!(
    body: Faker::Lorem.paragraphs(rand(1...7)).join,
    user_id: User.ids.sample
  )
  interview_comment2 = interview.comments.create!(
    body: Faker::Lorem.paragraphs(rand(1...8)).join,
    commenter_name: Faker::Name.name,
    commenter_email: Faker::Internet.email
  )
  interview_comment2.comments.create!(
    body: Faker::Lorem.paragraphs(rand(1...2)).join,
    user_id: User.ids.sample
  )
end
