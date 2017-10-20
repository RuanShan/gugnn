class SessionsController < Devise::SessionsController
  layout 'passport'

  def create
    if user_params[:verification_code]
      cellphone = user_params[:cellphone]
      self.resource = User.new
      resource.cellphone = cellphone
      user = User.where( cellphone: cellphone ).first
      if user
        sms = build_sms
        if sms.validate_for_sign_up( cellphone, user_params[:verification_code] )
          self.resource = user
          set_flash_message!(:notice, :signed_in)
          sign_in(resource_name, resource)
          yield resource if block_given?
          respond_with resource, location: after_sign_in_path_for(resource)
        else
          resource.errors.add("verification_code", sms.errors.first[1])
        end
      else
        resource.errors.add("cellphone", "手机号不存在")
      end
      if resource.errors.present?
        @login = "varifycode"
        render :new
      end
    else
      super
    end
  end

  def after_sign_in_path_for(resource)
    if resource.role_admin?
      admin_root_path
    else
      super
    end

  end

  private
    def user_params
      params.require(:user).permit(:cellphone, :password, :verification_code )
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
