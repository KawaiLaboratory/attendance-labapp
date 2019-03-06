require 'test_helper'

class LaboratoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get laboratories_index_url
    assert_response :success
  end

  test "should get show" do
    get laboratories_show_url
    assert_response :success
  end

  test "should get new" do
    get laboratories_new_url
    assert_response :success
  end

  test "should get edit" do
    get laboratories_edit_url
    assert_response :success
  end

  test "should get update" do
    get laboratories_update_url
    assert_response :success
  end

end
