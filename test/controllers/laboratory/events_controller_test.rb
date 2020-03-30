require 'test_helper'

class Laboratory::EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get laboratory_events_index_url
    assert_response :success
  end

  test "should get create" do
    get laboratory_events_create_url
    assert_response :success
  end

  test "should get update" do
    get laboratory_events_update_url
    assert_response :success
  end

end
