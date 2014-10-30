require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test 'profile display' do
    get user_path(@user)
    assert_select 'title', full_title(@user.name)
    assert_match @user.name, response.body
    assert_select 'img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
    assert_select 'div.stats'
    assert_match @user.following.count.to_s, response.body
    assert_match @user.followers.count.to_s, response.body
  end

  test 'only activated user profile display' do
    @user.activated = false
    @user.save
    get user_path(@user)
    assert_redirected_to root_url
  end
end
