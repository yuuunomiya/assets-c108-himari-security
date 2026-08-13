require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in users(:regular_user) }

  test "updates the user's own name and email" do
    patch profile_path, params: { user: { name: "新しい名前", email: "new@example.com" } }

    user = users(:regular_user).reload
    assert_equal "新しい名前", user.name
    assert_equal "new@example.com", user.email
    assert_redirected_to profile_path
  end

  # 第8章: マスアサインメントの回帰テスト。
  #
  # 脆弱性を含まないバージョン（安全・参考用）:
  test "cannot escalate to admin via mass assignment" do
    assert_not users(:regular_user).admin?

    patch profile_path, params: { user: { name: "x", admin: true } }

    assert_not users(:regular_user).reload.admin?
  end

  # test "escalates to admin via mass assignment" do
  #   assert_not users(:regular_user).admin?
  #
  #   patch profile_path, params: { user: { name: "x", admin: true } }
  #
  #   assert users(:regular_user).reload.admin?
  # end

  test "requires authentication" do
    sign_out users(:regular_user)
    get edit_profile_path

    assert_redirected_to new_user_session_path
  end
end
