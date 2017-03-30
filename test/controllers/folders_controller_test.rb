require 'test_helper'

class FoldersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @folder = folders(:one)
  end

  test "should get index" do
    get folders_url
    assert_response :success
  end

  test "should get new" do
    get new_folder_url
    assert_response :success
  end

  test "should create folder" do
    assert_difference('Folder.count') do
      post folders_url, params: { folder: { name: @folder.name, parent_id: @folder.parent_id, user_id: @folder.user_id } }
    end

    assert_redirected_to folder_url(Folder.last)
  end

  test "should show folder" do
    get folder_url(@folder)
    assert_response :success
  end

  test "should get edit" do
    get edit_folder_url(@folder)
    assert_response :success
  end

  test "should update folder" do
    patch folder_url(@folder), params: { folder: { name: @folder.name, parent_id: @folder.parent_id, user_id: @folder.user_id } }
    assert_redirected_to folder_url(@folder)
  end

  test "should destroy folder" do
    assert_difference('Folder.count', -1) do
      delete folder_url(@folder)
    end

    assert_redirected_to folders_url
  end
end
