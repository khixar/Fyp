require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get welcome_about_url
    assert_response :success
  end

  test "should get contact" do
    get welcome_contact_url
    assert_response :success
  end

  test "should get criteria" do
    get welcome_criteria_url
    assert_response :success
  end

  test "should get home" do
    get welcome_home_url
    assert_response :success
  end

  test "should get ranking" do
    get welcome_ranking_url
    assert_response :success
  end

  test "should get tutorial" do
    get welcome_tutorial_url
    assert_response :success
  end

end
