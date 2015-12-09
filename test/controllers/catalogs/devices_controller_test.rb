require 'test_helper'

class Catalogs::DevicesControllerTest < ActionController::TestCase
  setup do
    @catalogs_device = catalogs_devices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_devices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_device" do
    assert_difference('Catalogs::Device.count') do
      post :create, catalogs_device: { location_id: @catalogs_device.location_id, name: @catalogs_device.name, unam_stock_number: @catalogs_device.unam_stock_number }
    end

    assert_redirected_to catalogs_device_path(assigns(:catalogs_device))
  end

  test "should show catalogs_device" do
    get :show, id: @catalogs_device
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catalogs_device
    assert_response :success
  end

  test "should update catalogs_device" do
    patch :update, id: @catalogs_device, catalogs_device: { location_id: @catalogs_device.location_id, name: @catalogs_device.name, unam_stock_number: @catalogs_device.unam_stock_number }
    assert_redirected_to catalogs_device_path(assigns(:catalogs_device))
  end

  test "should destroy catalogs_device" do
    assert_difference('Catalogs::Device.count', -1) do
      delete :destroy, id: @catalogs_device
    end

    assert_redirected_to catalogs_devices_path
  end
end
