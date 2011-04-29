require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get config" do
    get :config
    assert_response :success
  end

end
