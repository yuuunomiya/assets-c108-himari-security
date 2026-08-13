require "test_helper"

class Admin::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "guest is redirected to the login page" do
    get admin_products_path

    assert_redirected_to new_user_session_path
  end

  test "non-admin user is redirected away from the admin area" do
    sign_in users(:regular_user)
    get admin_products_path

    assert_redirected_to root_path
  end

  test "admin user can access the admin area" do
    sign_in users(:admin_user)
    get admin_products_path

    assert_response :success
  end
end
