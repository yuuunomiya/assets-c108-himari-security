require "test_helper"

# ログイン後リダイレクトの回帰テスト（第9章）。
class LoginRedirectTest < ActionDispatch::IntegrationTest
  test "honors a same-origin relative redirect after login" do
    post user_session_path, params: {
      redirect_to: "/products",
      user: { email: "user@example.com", password: "password" }
    }

    assert_redirected_to "/products"
  end

  # 第9章: オープンリダイレクトの回帰テスト。
  #
  # 脆弱性を含まないバージョン（安全・参考用）:
  test "rejects an open redirect to an external host" do
    post user_session_path, params: {
      redirect_to: "//evil.example.com",
      user: { email: "user@example.com", password: "password" }
    }

    assert_redirected_to root_path
  end

  # test "currently follows an open redirect to an external host" do
  #   post user_session_path, params: {
  #     redirect_to: "//evil.example.com",
  #     user: { email: "user@example.com", password: "password" }
  #   }
  #
  #   assert_redirected_to "//evil.example.com"
  # end

  # 脆弱性を含まないバージョン（安全・参考用）:
  test "rejects a backslash-based open redirect" do
    post user_session_path, params: {
      redirect_to: "/\\evil.example.com",
      user: { email: "user@example.com", password: "password" }
    }

    assert_redirected_to root_path
  end

  # test "currently follows a backslash-based open redirect" do
  #   post user_session_path, params: {
  #     redirect_to: "/\\evil.example.com",
  #     user: { email: "user@example.com", password: "password" }
  #   }
  #
  #   assert_redirected_to "/\\evil.example.com"
  # end
end
