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
end
