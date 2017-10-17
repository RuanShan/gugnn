class RegistrationsController < Devise::RegistrationsController
  layout 'passport'

  #验证是否唯一
  def validate_cellphone
    cellphone = params[:cellphone]
    exists = User.exists?( cellphone: cellphone )
    render json: !exists
  end

  private

  def sign_up_params
    permitted_param_keys = [:cellphone, :verification_code]
    permitted_params = params.require(:user).permit(*permitted_param_keys)
    permitted_params['sms'] = build_sms
    permitted_params
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
