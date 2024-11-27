require "test_helper"

class UserAttendeesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_attendees_index_url
    assert_response :success
  end
end
