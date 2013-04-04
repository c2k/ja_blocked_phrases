require 'test_helper'

class JaBlockedPhrasesControllerTest < ActionController::TestCase
  setup do
    @ja_blocked_phrase = ja_blocked_phrases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ja_blocked_phrases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ja_blocked_phrase" do
    assert_difference('JaBlockedPhrase.count') do
      post :create, ja_blocked_phrase: { phrase: @ja_blocked_phrase.phrase }
    end

    assert_redirected_to ja_blocked_phrase_path(assigns(:ja_blocked_phrase))
  end

  test "should show ja_blocked_phrase" do
    get :show, id: @ja_blocked_phrase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ja_blocked_phrase
    assert_response :success
  end

  test "should update ja_blocked_phrase" do
    put :update, id: @ja_blocked_phrase, ja_blocked_phrase: { phrase: @ja_blocked_phrase.phrase }
    assert_redirected_to ja_blocked_phrase_path(assigns(:ja_blocked_phrase))
  end

  test "should destroy ja_blocked_phrase" do
    assert_difference('JaBlockedPhrase.count', -1) do
      delete :destroy, id: @ja_blocked_phrase
    end

    assert_redirected_to ja_blocked_phrases_path
  end
end
