require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "id status ready " do
    user = create :user
    user.id_auth_status_ready!
    assert user.id_auth_status_ready?
  end
end
