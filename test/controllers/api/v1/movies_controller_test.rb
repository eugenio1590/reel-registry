require "test_helper"

class Api::V1::MoviesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @user_movies = create_list(:movie, 3, user: @user)
    @shared_movies = create_list(:movie, 3, user: nil)
  end

  test "should return the movie list of the user and those of public access" do
    token = generate_auth_token(@user)
    headers = { 'Authorization' => "Bearer #{token}" }
    get api_v1_movies_url, headers: headers
    assert_response :success
    assert_equal @user_movies.count + @shared_movies.count,  JSON.parse(response.body)["data"].size
  end
end
