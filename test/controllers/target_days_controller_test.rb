require 'test_helper'

class TargetDaysControllerTest < ActionController::TestCase
  setup do
    @target_day = target_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:target_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create target_day" do
    assert_difference('TargetDay.count') do
      post :create, target_day: { checked: @target_day.checked, day: @target_day.day, month: @target_day.month, target_id: @target_day.target_id, year: @target_day.year }
    end

    assert_redirected_to target_day_path(assigns(:target_day))
  end

  test "should show target_day" do
    get :show, id: @target_day
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @target_day
    assert_response :success
  end

  test "should update target_day" do
    patch :update, id: @target_day, target_day: { checked: @target_day.checked, day: @target_day.day, month: @target_day.month, target_id: @target_day.target_id, year: @target_day.year }
    assert_redirected_to target_day_path(assigns(:target_day))
  end

  test "should destroy target_day" do
    assert_difference('TargetDay.count', -1) do
      delete :destroy, id: @target_day
    end

    assert_redirected_to target_days_path
  end
end
