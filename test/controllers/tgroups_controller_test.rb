require 'test_helper'

class TgroupsControllerTest < ActionController::TestCase
  setup do
    @tgroup = tgroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tgroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tgroup" do
    assert_difference('Tgroup.count') do
      post :create, tgroup: { name: @tgroup.name }
    end

    assert_redirected_to tgroup_path(assigns(:tgroup))
  end

  test "should show tgroup" do
    get :show, id: @tgroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tgroup
    assert_response :success
  end

  test "should update tgroup" do
    patch :update, id: @tgroup, tgroup: { name: @tgroup.name }
    assert_redirected_to tgroup_path(assigns(:tgroup))
  end

  test "should destroy tgroup" do
    assert_difference('Tgroup.count', -1) do
      delete :destroy, id: @tgroup
    end

    assert_redirected_to tgroups_path
  end
end
