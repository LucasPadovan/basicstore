require 'test_helper'

class PrecioproductosControllerTest < ActionController::TestCase
  setup do
    @precioproducto = precioproductos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:precioproductos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create precioproducto" do
    assert_difference('Precioproducto.count') do
      post :create, precioproducto: @precioproducto.attributes
    end

    assert_redirected_to precioproducto_path(assigns(:precioproducto))
  end

  test "should show precioproducto" do
    get :show, id: @precioproducto.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @precioproducto.to_param
    assert_response :success
  end

  test "should update precioproducto" do
    put :update, id: @precioproducto.to_param, precioproducto: @precioproducto.attributes
    assert_redirected_to precioproducto_path(assigns(:precioproducto))
  end

  test "should destroy precioproducto" do
    assert_difference('Precioproducto.count', -1) do
      delete :destroy, id: @precioproducto.to_param
    end

    assert_redirected_to precioproductos_path
  end
end
