require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test "login with invalid information" do
    get secure_path
    assert_template 'sessions/loginpage'
    post login_path, params: { session: { email: "aaa@aaa.com", password: "123" } }
    assert_template 'sessions/loginpage'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end