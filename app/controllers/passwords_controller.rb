class PasswordsController < Devise::PasswordsController
  before_action :verify_sign_up_sms, only: [:update]

  # PUT /resource/password
  def update
    error_message = User.validate_phone(user_params['cellphone'])
    if error_message=="cellphone_exist"
      self.resource = resource_class.find_by_cellphone(user_params['cellphone'])
      resource.reset_password(user_params[:password], user_params[:password_confirmation])
      yield resource if block_given?
      unless @sms.errors.empty?
        @sms.errors.each{|key, value|
          resource.errors.add(key, value)
        }
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

  def verify_sign_up_sms
    permitted_params = user_params
    serialized_sms = session[:sms]||{}
    logger.debug "serialized_sms=#{serialized_sms.inspect},permitted_params['verification_code']=#{permitted_params['verification_code']}"
    # sms serialized as json in session, it is string key hash here
    @sms = Sms.new( phone: serialized_sms['phone'], code: serialized_sms['code'], send_at: serialized_sms['send_at'])
    @sms.verify_sign_up_sms( permitted_params['cellphone'],permitted_params['verification_code'])
  end
end
