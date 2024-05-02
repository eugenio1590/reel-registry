require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test "should require a title" do
    movie = build(:movie, title: nil)
    assert_not movie.valid?, "Saved the movie without a title"
  end

  test "should require a release date" do
    movie = build(:movie, release_at: nil)
    assert_not movie.valid?, "Saved the movie without a release date"
  end

  test "should require a director" do
    movie = build(:movie, director: nil)
    assert_not movie.valid?, "Saved the movie without a director"
  end

  test "should require a genre" do
    movie = build(:movie, genre: nil)
    assert_not movie.valid?, "Saved the movie without a genre"
  end

  test "should require a synopsis" do
    movie = build(:movie, synopsis: nil)
    assert_not movie.valid?, "Saved the movie without a synopsis"
  end

  test "should require a duration" do
    movie = build(:movie, duration: nil)
    assert_not movie.valid?, "Saved the movie without a duration"
  end

  test "should require a duration greater than 0" do
    movie = build(:movie, duration: 0)
    assert_not movie.valid?, "Saved the movie with duration less than or equal to 0"
  end

  test "should accept valid fields" do
    movie = build(:movie)
    assert movie.valid?, "Factory is not valid"
  end

  test "should belong to user" do
    user = create(:user)
    movie = create(:movie, user: user)
    assert_equal user, movie.user
  end

  test "should be public if no user is associated" do
    movie = create(:movie, user: nil)
    assert_nil movie.user, "Movie should be public"
  end

  test "should return 'shared' movies" do
    shared_movie = create(:movie, user: nil)
    user_movie = create(:movie)

    shared_movies = Movie.shared

    assert_includes shared_movies, shared_movie
    refute_includes shared_movies, user_movie
  end

  test "should return user-'owned' movies" do
    user = create(:user)
    user_movie = create(:movie, user: user)
    other_user_movie = create(:movie)

    owned_movies = Movie.owned(user)

    assert_includes owned_movies, user_movie
    refute_includes owned_movies, other_user_movie
  end
end
