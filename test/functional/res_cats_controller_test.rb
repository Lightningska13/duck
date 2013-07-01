require 'test_helper'

class ResCatsControllerTest < ActionController::TestCase
  setup do
    @res_cat = res_cats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:res_cats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create res_cat" do
    assert_difference('ResCat.count') do
      post :create, :res_cat => { :description => @res_cat.description, :title => @res_cat.title }
    end

    assert_redirected_to res_cat_path(assigns(:res_cat))
  end

  test "should show res_cat" do
    get :show, :id => @res_cat
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @res_cat
    assert_response :success
  end

  test "should update res_cat" do
    put :update, :id => @res_cat, :res_cat => { :description => @res_cat.description, :title => @res_cat.title }
    assert_redirected_to res_cat_path(assigns(:res_cat))
  end

  test "should destroy res_cat" do
    assert_difference('ResCat.count', -1) do
      delete :destroy, :id => @res_cat
    end

    assert_redirected_to res_cats_path
  end
end
