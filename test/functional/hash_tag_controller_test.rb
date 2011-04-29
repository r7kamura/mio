require 'test_helper'

class HashTagControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
