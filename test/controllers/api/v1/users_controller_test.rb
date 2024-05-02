require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should create user" do
    assert_difference('User.count') do
      user = build(:user)
      post api_v1_users_url, params: { email: user.email, password: user.password }, as: :json
    end

    assert_response :created
    assert_nil JSON.parse(response.body)["password"]
  end

  test "should return errors if user creation fails" do
    user = build(:user, :invalid_email, :short_password)
    post api_v1_users_url, params: { email: user.email, password: user.password }, as: :json

    assert_response :unprocessable_entity
    assert_includes JSON.parse(response.body)["errors"], "Email is not a valid email format"
    assert_includes JSON.parse(response.body)["errors"], "Password is too short (minimum is 10 characters)"
  end
end
