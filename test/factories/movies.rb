FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    release_at { Faker::Date.between(from: 100.years.ago, to: Date.today) }
    director { Faker::Name.name }
    genre { Faker::Book.genre }
    synopsis { Faker::Lorem.paragraph(sentence_count: 2) }
    duration { Faker::Number.between(from: 60, to: 240) }
  end
end
