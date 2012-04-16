require 'test_helper'

class MediopagosControllerTest < ActionController::TestCase
  setup do
    @mediopago = mediopagos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mediopagos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mediopago" do
    assert_difference('Mediopago.count') do
      post :create, :mediopago => {:nombre => "Otro medio de pago",:descripcion => "Descripcion detallada"}
    end

    assert_redirected_to mediopago_path(assigns(:mediopago))
  end

  test "should show mediopago" do
    get :show, :id => @mediopago.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mediopago.to_param
    assert_response :success
  end

  test "should update mediopago" do
    put :update, :id => @mediopago.to_param, :mediopago => @mediopago.attributes
    assert_redirected_to mediopago_path(assigns(:mediopago))
  end

  test "should destroy mediopago" do
    assert_difference('Mediopago.count', -1) do
      delete :destroy, :id => @mediopago.to_param
    end

    assert_redirected_to mediopagos_path
  end
end
