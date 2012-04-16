require 'test_helper'

class EstadordensControllerTest < ActionController::TestCase
  setup do
    @estadorden = estadordens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estadordens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estadorden" do
    assert_difference('Estadorden.count') do
      post :create, estadorden: @estadorden.attributes
    end

    assert_redirected_to estadorden_path(assigns(:estadorden))
  end

  test "should show estadorden" do
    get :show, id: @estadorden.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @estadorden.to_param
    assert_response :success
  end

  test "should update estadorden" do
    put :update, id: @estadorden.to_param, estadorden: @estadorden.attributes
    assert_redirected_to estadorden_path(assigns(:estadorden))
  end

  test "should destroy estadorden" do
    assert_difference('Estadorden.count', -1) do
      delete :destroy, id: @estadorden.to_param
    end

    assert_redirected_to estadordens_path
  end
end
