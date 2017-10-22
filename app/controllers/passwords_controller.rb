class PasswordsController < Devise::PasswordsController

  # PUT /resource/password
  def update
    error_message = User.validate_phone(user_params['cellphone'])
    if error_message=="cellphone_exist"
      self.resource = resource_class.find_by_cellphone(user_params['cellphone'])
      sms = build_sms
      if sms.validate_for_sign_up( user_params['cellphone'], user_params[:verification_code] )
        resource.reset_password(user_params[:password], user_params[:password_confirmation])
        yield resource if block_given?
      else
        resource.errors.add("verification_code", sms.errors.first[1])
      end
    else
      self.resource = resource_class.new
      resource.errors.add("cellphone", t(error_message))
    end
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        sign_in(resource_name, resource)
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      render :new
    end
end

  private

  def user_params
    permitted_params = [:cellphone, :password, :password_confirmation, :verification_code]
    params.require(:user).permit(*permitted_params)
  end

  def build_sms
    # sms serialized as serializable_hash in session
    # session[:sms]= {"cellphone"=>"13889611691", "validation_context"=>nil, "errors"=>{}, "code"=>832050, "send_at"=>"2017-10-12T23:59:21.785+08:00"}
    # Rails.logger.debug "session[:sms]=#{session[:sms].inspect} "
    if session[:sms]
      permitted_params = session[:sms].slice 'cellphone', 'code', 'send_at'
      sms = Sms.new permitted_params
    else
      sms = Sms.new(  )
    end
  end

end
