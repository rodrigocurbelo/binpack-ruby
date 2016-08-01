require 'test_helper'

class BinPackingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bin_packing_index_url
    assert_response :success
  end

end
