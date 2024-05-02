require "test_helper"

class Api::V1::MoviesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @token = generate_auth_token(@user)
    @headers = { 'Authorization' => "Bearer #{@token}" }
    @user_movies = create_list(:movie, 3, user: @user)
    @shared_movies = create_list(:movie, 3, user: nil)
  end

  test "should return the movie list of the user and those of public access" do
    get api_v1_movies_url, headers: @headers
    assert_response :success
    assert_equal @user_movies.count + @shared_movies.count,  JSON.parse(response.body)["data"].size
  end

  test "should return the movie information belonging to a user" do
    @movie = @user_movies.first
    get api_v1_movie_url(@movie), headers: @headers
    assert_response :success
    assert_not_nil JSON.parse(response.body)["data"]
  end

  test "should return the shared movie information" do
    @movie = @shared_movies.first
    get api_v1_movie_url(@movie), headers: @headers
    assert_response :success
    assert_not_nil JSON.parse(response.body)["data"]
  end

  test "should not retrieve a movie belonging to another user" do
    @movie = create(:movie, user: create(:user))
    get api_v1_movie_url(@movie), headers: @headers
    assert_response :not_found
  end
end