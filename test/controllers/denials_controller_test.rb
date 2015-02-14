require 'test_helper'

class DenialsControllerTest < ActionController::TestCase
  setup do
    @denial = denials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:denials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create denial" do
    assert_difference('Denial.count') do
      post :create, denial: { name: @denial.name, start_date: @denial.start_date }
    end

    assert_redirected_to denial_path(assigns(:denial))
  end

  test "should show denial" do
    get :show, id: @denial
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @denial
    assert_response :success
  end

  test "should update denial" do
    patch :update, id: @denial, denial: { name: @denial.name, start_date: @denial.start_date }
    assert_redirected_to denial_path(assigns(:denial))
  end

  test "should destroy denial" do
    assert_difference('Denial.count', -1) do
      delete :destroy, id: @denial
    end

    assert_redirected_to denials_path
  end
end
