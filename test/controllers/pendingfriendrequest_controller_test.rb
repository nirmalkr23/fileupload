require "test_helper"

class PendingfriendrequestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pendingfriendrequest_index_url
    assert_response :success
  end
end
