require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should create user" do
    assert_difference('User.count') do
      post api_v1_users_url, params: build(:user).as_json, as: :json
    end

    assert_response :created
    assert_nil JSON.parse(response.body)["password"]
  end

  test "should return errors if user creation fails" do
    post api_v1_users_url, params: build(:user, :invalid_email, :short_password).as_json, as: :json

    assert_response :unprocessable_entity
    assert_includes JSON.parse(response.body)["errors"], "Email is not a valid email format"
    assert_includes JSON.parse(response.body)["errors"], "Password is too short (minimum is 10 characters)"
  end
end
