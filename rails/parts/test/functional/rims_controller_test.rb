require 'test_helper'

class RimsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rims)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show rim" do
    get :show, :id => rims(:open_pro).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => rims(:open_pro).id
    assert_response :success
  end

  test "should update rim" do
    put :update, :id => rims(:open_pro).id, :rim => { }
    assert_redirected_to rim_path(assigns(:rim))
  end

  test "should destroy rim" do
    assert_difference('Rim.count', -1) do
      delete :destroy, :id => rims(:open_pro).id
    end

    assert_redirected_to rims_path
  end
end
