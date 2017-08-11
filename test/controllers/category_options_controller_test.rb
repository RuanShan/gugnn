require 'test_helper'

class CategoryOptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category_option = category_options(:one)
  end

  test "should get index" do
    get category_options_url
    assert_response :success
  end

  test "should get new" do
    get new_category_option_url
    assert_response :success
  end

  test "should create category_option" do
    assert_difference('CategoryOption.count') do
      post category_options_url, params: { category_option: { title: @category_option.title } }
    end

    assert_redirected_to category_option_url(CategoryOption.last)
  end

  test "should show category_option" do
    get category_option_url(@category_option)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_option_url(@category_option)
    assert_response :success
  end

  test "should update category_option" do
    patch category_option_url(@category_option), params: { category_option: { title: @category_option.title } }
    assert_redirected_to category_option_url(@category_option)
  end

  test "should destroy category_option" do
    assert_difference('CategoryOption.count', -1) do
      delete category_option_url(@category_option)
    end

    assert_redirected_to category_options_url
  end
end
