require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get members_update_url
    assert_response :success
  end

end
