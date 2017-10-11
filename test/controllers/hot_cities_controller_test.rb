require 'test_helper'

class HotCitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hot_city = hot_cities(:one)
  end

  test "should get index" do
    get hot_cities_url
    assert_response :success
  end

  test "should get new" do
    get new_hot_city_url
    assert_response :success
  end

  test "should create hot_city" do
    assert_difference('HotCity.count') do
      post hot_cities_url, params: { hot_city: { acronyms: @hot_city.acronyms, integer: @hot_city.integer, name: @hot_city.name, pingyi: @hot_city.pingyi, province: @hot_city.province, status: @hot_city.status } }
    end

    assert_redirected_to hot_city_url(HotCity.last)
  end

  test "should show hot_city" do
    get hot_city_url(@hot_city)
    assert_response :success
  end

  test "should get edit" do
    get edit_hot_city_url(@hot_city)
    assert_response :success
  end

  test "should update hot_city" do
    patch hot_city_url(@hot_city), params: { hot_city: { acronyms: @hot_city.acronyms, integer: @hot_city.integer, name: @hot_city.name, pingyi: @hot_city.pingyi, province: @hot_city.province, status: @hot_city.status } }
    assert_redirected_to hot_city_url(@hot_city)
  end

  test "should destroy hot_city" do
    assert_difference('HotCity.count', -1) do
      delete hot_city_url(@hot_city)
    end

    assert_redirected_to hot_cities_url
  end
end
