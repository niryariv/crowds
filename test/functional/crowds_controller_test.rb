require 'test_helper'

class CrowdsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crowds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create crowds" do
    assert_difference('Crowds.count') do
      post :create, :crowds => { }
    end

    assert_redirected_to crowds_path(assigns(:crowds))
  end

  test "should show crowds" do
    get :show, :id => crowds(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => crowds(:one).id
    assert_response :success
  end

  test "should update crowds" do
    put :update, :id => crowds(:one).id, :crowds => { }
    assert_redirected_to crowds_path(assigns(:crowds))
  end

  test "should destroy crowds" do
    assert_difference('Crowds.count', -1) do
      delete :destroy, :id => crowds(:one).id
    end

    assert_redirected_to crowds_path
  end
end
