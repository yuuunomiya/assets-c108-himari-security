require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "admin? returns true only for admin users" do
    assert users(:admin_user).admin?
    assert_not users(:regular_user).admin?
  end
end
