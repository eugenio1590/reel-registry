require 'test_helper'

class MoviePolicyTest < ActiveSupport::TestCase

  def setup
    @user = create(:user)
    @other_user = create(:user)
    @public_movie = create(:movie, user: nil)
    @user_movie = create(:movie, user: @user)
    @other_user_movie = create(:movie, user: @other_user)
  end

  test "user can index movies" do
    assert MoviePolicy.new(@user, Movie).index?
  end

  test "user can show public movie" do
    assert MoviePolicy.new(@user, @public_movie).show?
  end

  test "user can show own movie" do
    assert MoviePolicy.new(@user, @user_movie).show?
  end

  test "user cannot show other user's movie" do
    refute MoviePolicy.new(@user, @other_user_movie).show?
  end

  test "user can create a movie" do
    assert MoviePolicy.new(@user, Movie).create?
  end

  test "user can update own movie" do
    assert MoviePolicy.new(@user, @user_movie).update?
  end

  test "user cannot update other user's movie" do
    refute MoviePolicy.new(@user, @other_user_movie).update?
  end

  test "user can destroy own movie" do
    assert MoviePolicy.new(@user, @user_movie).destroy?
  end
  
  test "user cannot destroy other user's movie" do
    refute MoviePolicy.new(@user, @other_user_movie).destroy?
  end

  test "scope returns shared and user's movies for authenticated user" do
    user_scope = MoviePolicy::Scope.new(@user, Movie).resolve
    assert_includes user_scope, @user_movie
    assert_includes user_scope, @public_movie
    assert_not_includes user_scope, @other_user_movie
  end
end
