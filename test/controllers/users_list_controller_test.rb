require "test_helper"

class UsersListControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_list_index_url
    assert_response :success
  end
end
