require 'test_helper'

class UserProfileTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "shows user name and email" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'h1', text: @user.name
    assert_select 'p', text: @user.email
  end
end
