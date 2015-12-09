require 'test_helper'

class System::RenewalsControllerTest < ActionController::TestCase
  setup do
    @system_renewal = system_renewals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:system_renewals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create system_renewal" do
    assert_difference('System::Renewal.count') do
      post :create, system_renewal: { contract_id: @system_renewal.contract_id, end_date: @system_renewal.end_date, start_date: @system_renewal.start_date }
    end

    assert_redirected_to system_renewal_path(assigns(:system_renewal))
  end

  test "should show system_renewal" do
    get :show, id: @system_renewal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @system_renewal
    assert_response :success
  end

  test "should update system_renewal" do
    patch :update, id: @system_renewal, system_renewal: { contract_id: @system_renewal.contract_id, end_date: @system_renewal.end_date, start_date: @system_renewal.start_date }
    assert_redirected_to system_renewal_path(assigns(:system_renewal))
  end

  test "should destroy system_renewal" do
    assert_difference('System::Renewal.count', -1) do
      delete :destroy, id: @system_renewal
    end

    assert_redirected_to system_renewals_path
  end
end
