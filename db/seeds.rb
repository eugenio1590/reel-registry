# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

movies = [
  { title: "Inception", release_at: "2010-07-16", director: "Christopher Nolan", genre: "Sci-Fi", synopsis: "A thief who enters the dreams of others to steal their secrets.", duration: 148 },
  { title: "Pulp Fiction", release_at: "1994-10-14", director: "Quentin Tarantino", genre: "Crime", synopsis: "The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.", duration: 154 },
  { title: "The Matrix", release_at: "1999-03-31", director: "Lana Wachowski, Lilly Wachowski", genre: "Action", synopsis: "A computer hacker learns about the true nature of his reality and his role in the war against its controllers.", duration: 136 },
  { title: "Forrest Gump", release_at: "1994-07-06", director: "Robert Zemeckis", genre: "Drama", synopsis: "The presidencies of Kennedy and Johnson, the events of Vietnam, Watergate, and other historical events unfold from the perspective of an Alabama man with an IQ of 75.", duration: 142 },
  { title: "The Lord of the Rings: The Fellowship of the Ring", release_at: "2001-12-19", director: "Peter Jackson", genre: "Fantasy", synopsis: "A meek Hobbit and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.", duration: 178 }
]

movies.each do |data|
  Movie.create!(data)
end
