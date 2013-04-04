require 'test_helper'

class JaBlockedRootsControllerTest < ActionController::TestCase
  setup do
    @ja_blocked_root = ja_blocked_roots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ja_blocked_roots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ja_blocked_root" do
    assert_difference('JaBlockedRoot.count') do
      post :create, ja_blocked_root: { root: @ja_blocked_root.root }
    end

    assert_redirected_to ja_blocked_root_path(assigns(:ja_blocked_root))
  end

  test "should show ja_blocked_root" do
    get :show, id: @ja_blocked_root
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ja_blocked_root
    assert_response :success
  end

  test "should update ja_blocked_root" do
    put :update, id: @ja_blocked_root, ja_blocked_root: { root: @ja_blocked_root.root }
    assert_redirected_to ja_blocked_root_path(assigns(:ja_blocked_root))
  end

  test "should destroy ja_blocked_root" do
    assert_difference('JaBlockedRoot.count', -1) do
      delete :destroy, id: @ja_blocked_root
    end

    assert_redirected_to ja_blocked_roots_path
  end
end
