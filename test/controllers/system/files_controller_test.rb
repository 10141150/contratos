require 'test_helper'

class System::FilesControllerTest < ActionController::TestCase
  test "should get load_files" do
    get :load_files
    assert_response :success
  end

  test "should get list_files" do
    get :list_files
    assert_response :success
  end

  test "should get delete_files" do
    get :delete_files
    assert_response :success
  end

  test "should get save_comments" do
    get :save_comments
    assert_response :success
  end

end
