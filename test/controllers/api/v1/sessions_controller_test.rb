require "test_helper"

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should return the user information with the auth token" do
    password = "ValidPassword!"
    user = create(:user, email: "test@example.com", password: password)

    post api_v1_sessions_url, params: { email: user.email, password: password }, as: :json

    assert_response :success
    assert_not_nil JSON.parse(response.body)["data"]
    assert_not_nil JSON.parse(response.body)["meta"]["auth_token"]
  end

  test "should return unauthorized if credentials are invalid" do
    user = create(:user)

    post api_v1_sessions_url, params: { email: user.email, password: "invalid" }, as: :json

    assert_response :unauthorized
    assert_equal "Invalid credentials", JSON.parse(response.body)["error"]
  end

  test "should return an error if the email provided is not registered" do
    post api_v1_sessions_url, params: { email: "not_found@example.com", password: "password123" }, as: :json

    assert_response :unprocessable_entity
    assert_equal "The email provided is not registered", JSON.parse(response.body)["error"]
  end
end
