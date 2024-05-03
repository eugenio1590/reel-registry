require "test_helper"

class Api::V1::MoviesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @token = generate_auth_token(@user.id)
    @headers = { 'Authorization' => "Bearer #{@token}" }
    @user_movies = create_list(:movie, 3, user: @user)
    @shared_movies = create_list(:movie, 3, user: nil)
  end

  test "should return the movie list belonging to a user and those of shared access" do
    get api_v1_movies_url, headers: @headers
    assert_response :success
    assert_equal @user_movies.count + @shared_movies.count, JSON.parse(response.body)["data"].size
  end

  test "should return the movie list belonging to a user" do
    get api_v1_movies_url(filter: 'owned'), headers: @headers
    assert_response :success
    assert_equal @user_movies.count, JSON.parse(response.body)["data"].size
  end

  test "should return the shared movie list" do
    get api_v1_movies_url(filter: 'shared'), headers: @headers
    assert_response :success
    assert_equal @shared_movies.count, JSON.parse(response.body)["data"].size
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

  test "should create a shared movie with valid parameters" do
    assert_difference('Movie.count') do
      post api_v1_movies_url, params: attributes_for(:movie), headers: @headers
    end

    assert_response :created
    assert_not_nil JSON.parse(response.body)["data"]
  end

  test "should create a movie belonging to a user with valid parameters" do
    assert_difference('Movie.count') do
      post api_v1_movies_url, params: attributes_for(:movie, user_id: @user.id),  headers: @headers
    end

    assert_response :created
    assert_not_nil JSON.parse(response.body)["data"]
    assert_equal @user_movies.count + 1, @user.movies.count
  end

  test "should not create a movie with invalid parameters" do
    assert_no_difference('Movie.count') do
      post api_v1_movies_url, params: attributes_for(:movie, title: nil), headers: @headers
    end

    assert_response :unprocessable_entity
    assert_not_nil JSON.parse(response.body)["errors"]
  end

  test "should not create a movie for another user" do
    assert_no_difference('Movie.count') do
      post api_v1_movies_url, params: attributes_for(:movie, user_id: create(:user).id), headers: @headers
    end

    assert_response :forbidden
    assert_not_nil JSON.parse(response.body)["errors"]
  end

  test "should update a movie belonging to a user with valid parameters" do
    @movie = @user_movies.first
    @movie.title = "updated title"

    patch api_v1_movie_url(@movie), params: @movie.attributes, headers: @headers

    assert_response :ok
  end

  test "should not update a movie with invalid parameters" do
    @movie = @user_movies.first
    @movie.title = nil

    patch api_v1_movie_url(@movie), params: @movie.attributes, headers: @headers

    assert_response :unprocessable_entity
    assert_not_nil JSON.parse(response.body)["errors"]
  end

  test "should not update a movie for another user" do
    @movie = create(:movie, user_id: create(:user).id)
    @movie.title = "updated title"

    patch api_v1_movie_url(@movie), params: @movie.attributes, headers: @headers

    assert_response :not_found
  end

  test "should delete a movie belonging to a user" do
    @movie = @user_movies.first

    delete api_v1_movie_url(@movie), params: @movie.attributes, headers: @headers

    assert_response :no_content
  end

  test "should not delete a shared movie" do
    @movie = @shared_movies.first

    delete api_v1_movie_url(@movie), params: @movie.attributes, headers: @headers

    assert_response :forbidden
    assert_not_nil JSON.parse(response.body)["errors"]
  end

  test "should not delete a movie for another user" do
    @movie = create(:movie, user_id: create(:user).id)

    delete api_v1_movie_url(@movie), params: @movie.attributes, headers: @headers

    assert_response :not_found
  end
end
