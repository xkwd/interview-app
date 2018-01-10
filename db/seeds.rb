country_cities_list = {"Australia" => ["Melbourne"],
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
                       "United States" => ["New York", "Los Angeles"]}
Country.delete_all
country_cities_list.keys.each do |country|
  Country.create!(
    name: country
  )
end

City.delete_all
country_cities_list.each do |k,v|
  v.each do |city|
    City.create!(
      name: city,
      country_id: Country.find_by(name: k).id
    )
  end
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
    user_id: User.ids[i-1],
    country_id: Country.ids.sample
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
