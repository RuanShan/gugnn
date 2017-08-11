require 'test_helper'

class OfficeEquipmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @office_equipment = office_equipments(:one)
  end

  test "should get index" do
    get office_equipments_url
    assert_response :success
  end

  test "should get new" do
    get new_office_equipment_url
    assert_response :success
  end

  test "should create office_equipment" do
    assert_difference('OfficeEquipment.count') do
      post office_equipments_url, params: { office_equipment: { desc: @office_equipment.desc, owner_id: @office_equipment.owner_id, price: @office_equipment.price, slugged: @office_equipment.slugged, title: @office_equipment.title } }
    end

    assert_redirected_to office_equipment_url(OfficeEquipment.last)
  end

  test "should show office_equipment" do
    get office_equipment_url(@office_equipment)
    assert_response :success
  end

  test "should get edit" do
    get edit_office_equipment_url(@office_equipment)
    assert_response :success
  end

  test "should update office_equipment" do
    patch office_equipment_url(@office_equipment), params: { office_equipment: { desc: @office_equipment.desc, owner_id: @office_equipment.owner_id, price: @office_equipment.price, slugged: @office_equipment.slugged, title: @office_equipment.title } }
    assert_redirected_to office_equipment_url(@office_equipment)
  end

  test "should destroy office_equipment" do
    assert_difference('OfficeEquipment.count', -1) do
      delete office_equipment_url(@office_equipment)
    end

    assert_redirected_to office_equipments_url
  end
end
