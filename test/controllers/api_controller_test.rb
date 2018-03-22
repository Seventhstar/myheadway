require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get random_statement" do
    get api_random_statement_url
    assert_response :success
  end

end
