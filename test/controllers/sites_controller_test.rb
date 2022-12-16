require "test_helper"

class SitesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get sites_home_url
    assert_response :success
  end

  test "should get csv_sample" do
    get sites_csv_sample_url
    assert_response :success
  end
end
