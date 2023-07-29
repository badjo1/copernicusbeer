require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

   def setup
    @user = users(:one)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'user_sessions/show'
    post login_path, params: { user_session: { eth_address: @user.eth_address, eth_message: 'invalid_message', eth_signature: 'invalid_signature' } }
    assert_template 'user_sessions/show'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { user_session: { eth_address: @user.eth_address, eth_message: 'fLFRSkCea_N5RLKAJqyYCw', eth_signature: '0x5b656af34dec5fee4e58305a50fdb464e287bc9d6dc98134b31ccabd4efbc9306d6233cbcab515154228d66659610826aa717a5a92781c35a0331a8263ee60c41c' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

end
