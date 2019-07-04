require 'test_helper'

class ChatroomControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get chatroom_new_url
    assert_response :success
  end

end
