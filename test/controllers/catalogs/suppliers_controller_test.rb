require 'test_helper'

class Catalogs::SuppliersControllerTest < ActionController::TestCase
  setup do
    @catalogs_supplier = catalogs_suppliers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_suppliers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_supplier" do
    assert_difference('Catalogs::Supplier.count') do
      post :create, catalogs_supplier: { business_name: @catalogs_supplier.business_name, contact: @catalogs_supplier.contact, email: @catalogs_supplier.email, phone: @catalogs_supplier.phone }
    end

    assert_redirected_to catalogs_supplier_path(assigns(:catalogs_supplier))
  end

  test "should show catalogs_supplier" do
    get :show, id: @catalogs_supplier
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catalogs_supplier
    assert_response :success
  end

  test "should update catalogs_supplier" do
    patch :update, id: @catalogs_supplier, catalogs_supplier: { business_name: @catalogs_supplier.business_name, contact: @catalogs_supplier.contact, email: @catalogs_supplier.email, phone: @catalogs_supplier.phone }
    assert_redirected_to catalogs_supplier_path(assigns(:catalogs_supplier))
  end

  test "should destroy catalogs_supplier" do
    assert_difference('Catalogs::Supplier.count', -1) do
      delete :destroy, id: @catalogs_supplier
    end

    assert_redirected_to catalogs_suppliers_path
  end
end
