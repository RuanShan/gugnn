require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should create user" do
    user_params = { verification_code: '999999', cellphone: '13800000000'}
    #session[:sms] = Sms.new(  cellphone: user_params[:cellphone], code: user_params[:verification_code] )
    assert_difference('User.count') do
      post user_registration_url, params: { user: user_params, session:{ sms: Sms.new(  cellphone: user_params[:cellphone], code: user_params[:verification_code] )} }
    end

    assert_redirected_to user_url(User.last)
  end


  #test "should get edit" do
  #  get edit_user_url(@user)
  #  assert_response :success
  #end

  #test "should update user" do
  #  patch user_url(@user), params: { user: { desc: @user.desc, owner_id: @user.owner_id, price: @user.price, slugged: @user.slugged, title: @user.title } }
  #  assert_redirected_to user_url(@user)
  #end

  #test "should destroy user" do
  #  assert_difference('Product.count', -1) do
  #    delete user_url(@user)
  #  end
  #  assert_redirected_to users_url
  #end
end
