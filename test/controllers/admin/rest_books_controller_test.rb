require 'test_helper'

class Admin::RestBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_rest_books_index_url
    assert_response :success
  end

end
