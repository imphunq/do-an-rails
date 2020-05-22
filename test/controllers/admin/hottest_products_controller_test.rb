require 'test_helper'

class Admin::HottestProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_hottest_products_index_url
    assert_response :success
  end

end
