require 'test_helper'

class ProductOptionValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_option_value = product_option_values(:one)
  end

  test "should get index" do
    get product_option_values_url
    assert_response :success
  end

  test "should get new" do
    get new_product_option_value_url
    assert_response :success
  end

  test "should create product_option_value" do
    assert_difference('ProductOptionValue.count') do
      post product_option_values_url, params: { product_option_value: { category_id: @product_option_value.category_id, category_option_id: @product_option_value.category_option_id, product_id: @product_option_value.product_id, title: @product_option_value.title } }
    end

    assert_redirected_to product_option_value_url(ProductOptionValue.last)
  end

  test "should show product_option_value" do
    get product_option_value_url(@product_option_value)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_option_value_url(@product_option_value)
    assert_response :success
  end

  test "should update product_option_value" do
    patch product_option_value_url(@product_option_value), params: { product_option_value: { category_id: @product_option_value.category_id, category_option_id: @product_option_value.category_option_id, product_id: @product_option_value.product_id, title: @product_option_value.title } }
    assert_redirected_to product_option_value_url(@product_option_value)
  end

  test "should destroy product_option_value" do
    assert_difference('ProductOptionValue.count', -1) do
      delete product_option_value_url(@product_option_value)
    end

    assert_redirected_to product_option_values_url
  end
end
