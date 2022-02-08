require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user can be created" do
    user = User.new
    user.valid?
  end
end
