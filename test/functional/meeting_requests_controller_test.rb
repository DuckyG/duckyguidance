require 'test_helper'

class MeetingRequestsControllerTest < ActionController::TestCase
  setup do
    @meeting_request = meeting_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meeting_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meeting_request" do
    assert_difference('MeetingRequest.count') do
      post :create, :meeting_request => @meeting_request.attributes
    end

    assert_redirected_to meeting_request_path(assigns(:meeting_request))
  end

  test "should show meeting_request" do
    get :show, :id => @meeting_request.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @meeting_request.to_param
    assert_response :success
  end

  test "should update meeting_request" do
    put :update, :id => @meeting_request.to_param, :meeting_request => @meeting_request.attributes
    assert_redirected_to meeting_request_path(assigns(:meeting_request))
  end

  test "should destroy meeting_request" do
    assert_difference('MeetingRequest.count', -1) do
      delete :destroy, :id => @meeting_request.to_param
    end

    assert_redirected_to meeting_requests_path
  end
end
