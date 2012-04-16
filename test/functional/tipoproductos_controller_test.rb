require 'test_helper'

class TipoproductosControllerTest < ActionController::TestCase
  setup do
    @tipoproducto = tipoproductos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipoproductos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipoproducto" do
    assert_difference('Tipoproducto.count') do
      post :create, tipoproducto: @tipoproducto.attributes
    end

    assert_redirected_to tipoproducto_path(assigns(:tipoproducto))
  end

  test "should show tipoproducto" do
    get :show, id: @tipoproducto.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipoproducto.to_param
    assert_response :success
  end

  test "should update tipoproducto" do
    put :update, id: @tipoproducto.to_param, tipoproducto: @tipoproducto.attributes
    assert_redirected_to tipoproducto_path(assigns(:tipoproducto))
  end

  test "should destroy tipoproducto" do
    assert_difference('Tipoproducto.count', -1) do
      delete :destroy, id: @tipoproducto.to_param
    end

    assert_redirected_to tipoproductos_path
  end
end
