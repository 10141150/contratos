require 'test_helper'

class System::ContractsControllerTest < ActionController::TestCase
  setup do
    @system_contract = system_contracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:system_contracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create system_contract" do
    assert_difference('System::Contract.count') do
      post :create, system_contract: { contract_no: @system_contract.contract_no, device_id: @system_contract.device_id, end_date: @system_contract.end_date, start_date: @system_contract.start_date, supplier_id: @system_contract.supplier_id }
    end

    assert_redirected_to system_contract_path(assigns(:system_contract))
  end

  test "should show system_contract" do
    get :show, id: @system_contract
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @system_contract
    assert_response :success
  end

  test "should update system_contract" do
    patch :update, id: @system_contract, system_contract: { contract_no: @system_contract.contract_no, device_id: @system_contract.device_id, end_date: @system_contract.end_date, start_date: @system_contract.start_date, supplier_id: @system_contract.supplier_id }
    assert_redirected_to system_contract_path(assigns(:system_contract))
  end

  test "should destroy system_contract" do
    assert_difference('System::Contract.count', -1) do
      delete :destroy, id: @system_contract
    end

    assert_redirected_to system_contracts_path
  end
end
