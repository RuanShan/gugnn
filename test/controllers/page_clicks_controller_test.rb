require 'test_helper'

class PageClicksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page_click = page_clicks(:one)
  end

  test "should get index" do
    get page_clicks_url
    assert_response :success
  end

  test "should get new" do
    get new_page_click_url
    assert_response :success
  end

  test "should create page_click" do
    assert_difference('PageClick.count') do
      post page_clicks_url, params: { page_click: { pv: @page_click.pv, uv: @page_click.uv } }
    end

    assert_redirected_to page_click_url(PageClick.last)
  end

  test "should show page_click" do
    get page_click_url(@page_click)
    assert_response :success
  end

  test "should get edit" do
    get edit_page_click_url(@page_click)
    assert_response :success
  end

  test "should update page_click" do
    patch page_click_url(@page_click), params: { page_click: { pv: @page_click.pv, uv: @page_click.uv } }
    assert_redirected_to page_click_url(@page_click)
  end

  test "should destroy page_click" do
    assert_difference('PageClick.count', -1) do
      delete page_click_url(@page_click)
    end

    assert_redirected_to page_clicks_url
  end
end
