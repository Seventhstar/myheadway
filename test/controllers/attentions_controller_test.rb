require 'test_helper'

class AttentionsControllerTest < ActionController::TestCase
  setup do
    @attention = attentions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attentions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attention" do
    assert_difference('Attention.count') do
      post :create, attention: { attn_cat_id: @attention.attn_cat_id, description: @attention.description, img_url: @attention.img_url, name: @attention.name, src_url: @attention.src_url, user_id: @attention.user_id }
    end

    assert_redirected_to attention_path(assigns(:attention))
  end

  test "should show attention" do
    get :show, id: @attention
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attention
    assert_response :success
  end

  test "should update attention" do
    patch :update, id: @attention, attention: { attn_cat_id: @attention.attn_cat_id, description: @attention.description, img_url: @attention.img_url, name: @attention.name, src_url: @attention.src_url, user_id: @attention.user_id }
    assert_redirected_to attention_path(assigns(:attention))
  end

  test "should destroy attention" do
    assert_difference('Attention.count', -1) do
      delete :destroy, id: @attention
    end

    assert_redirected_to attentions_path
  end
end
