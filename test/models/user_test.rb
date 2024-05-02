require "test_helper"

class UserTest < ActiveSupport::TestCase

  # Email validation

  test "should require an email" do
    user = build(:user, email: nil)
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "should require a valid email format" do
    user = build(:user, :invalid_email)
    assert_not user.valid?
    assert_includes user.errors[:email], "is not a valid email format"
  end

  test "should have unique email" do
    existing_user = create(:user, email: "test@example.com")

    duplicate_user = build(:user, email: "test@example.com")

    assert_equal existing_user.email, duplicate_user.email
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email], "has already been taken"
  end

  # Password validation

  test "should require a password" do
    user = build(:user, password: nil)
    assert_not user.valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  test "should require a password with at least 10 characters" do
    user = build(:user, :short_password)
    assert_not user.valid?
    assert_includes user.errors[:password], "is too short (minimum is 10 characters)"
  end

  test "should require a password with at least one lowercase letter" do
    user = build(:user, :no_lowercase_password)
    assert_not user.valid?
    assert_includes user.errors[:password], "must include at least one lowercase letter"
  end

  test "should require a password with at least one uppercase letter" do
    user = build(:user, :no_uppercase_password)
    assert_not user.valid?
    assert_includes user.errors[:password], "must include at least one uppercase letter"
  end

  test "should require a password with at least one special character" do
    user = build(:user, :no_special_char_password)
    assert_not user.valid?
    assert_includes user.errors[:password], "must include at least one of the following characters: !, @, #, ?, or ]"
  end

  # Valid fields

  test "should accept a valid email and password" do
    user = build(:user)
    assert user.valid?
  end
end
