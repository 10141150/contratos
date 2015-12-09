require 'test_helper'

class System::SiteviewsControllerTest < ActionController::TestCase
  setup do
    @system_siteview = system_siteviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:system_siteviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create system_siteview" do
    assert_difference('System::Siteview.count') do
      post :create, system_siteview: { completed: @system_siteview.completed, contract_id: @system_siteview.contract_id, visit_date: @system_siteview.visit_date }
    end

    assert_redirected_to system_siteview_path(assigns(:system_siteview))
  end

  test "should show system_siteview" do
    get :show, id: @system_siteview
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @system_siteview
    assert_response :success
  end

  test "should update system_siteview" do
    patch :update, id: @system_siteview, system_siteview: { completed: @system_siteview.completed, contract_id: @system_siteview.contract_id, visit_date: @system_siteview.visit_date }
    assert_redirected_to system_siteview_path(assigns(:system_siteview))
  end

  test "should destroy system_siteview" do
    assert_difference('System::Siteview.count', -1) do
      delete :destroy, id: @system_siteview
    end

    assert_redirected_to system_siteviews_path
  end
end
