require 'test_helper'

class CounselorsControllerTest < ActionController::TestCase
  setup do
    @counselor = counselors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:counselors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create counselor" do
    assert_difference('Counselor.count') do
      post :create, :counselor => @counselor.attributes
    end

    assert_redirected_to counselor_path(assigns(:counselor))
  end

  test "should show counselor" do
    get :show, :id => @counselor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @counselor.to_param
    assert_response :success
  end

  test "should update counselor" do
    put :update, :id => @counselor.to_param, :counselor => @counselor.attributes
    assert_redirected_to counselor_path(assigns(:counselor))
  end

  test "should destroy counselor" do
    assert_difference('Counselor.count', -1) do
      delete :destroy, :id => @counselor.to_param
    end

    assert_redirected_to counselors_path
  end
end
