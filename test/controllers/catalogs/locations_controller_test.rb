require 'test_helper'

class Catalogs::LocationsControllerTest < ActionController::TestCase
  setup do
    @catalogs_location = catalogs_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_location" do
    assert_difference('Catalogs::Location.count') do
      post :create, catalogs_location: { department: @catalogs_location.department, email: @catalogs_location.email, responsible: @catalogs_location.responsible }
    end

    assert_redirected_to catalogs_location_path(assigns(:catalogs_location))
  end

  test "should show catalogs_location" do
    get :show, id: @catalogs_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catalogs_location
    assert_response :success
  end

  test "should update catalogs_location" do
    patch :update, id: @catalogs_location, catalogs_location: { department: @catalogs_location.department, email: @catalogs_location.email, responsible: @catalogs_location.responsible }
    assert_redirected_to catalogs_location_path(assigns(:catalogs_location))
  end

  test "should destroy catalogs_location" do
    assert_difference('Catalogs::Location.count', -1) do
      delete :destroy, id: @catalogs_location
    end

    assert_redirected_to catalogs_locations_path
  end
end
