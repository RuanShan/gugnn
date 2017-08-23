class RegistrationsController < Devise::RegistrationsController
  before_action :verify_sign_up_sms, only: [:create]

  #验证是否唯一
  def validate_cellphone
    cellphone = params[:cellphone]
    exists = User.exists?( cellphone: cellphone )
    render json: !exists
  end

  private

  def sign_up_params
    permitted_params = [:cellphone, :nickname, :password, :validate_code]
    params.require(:user).permit(*permitted_params)
  end

  def verify_sign_up_sms
    permitted_params = sign_up_params
    serialized_sms = session[:sms]||{}
    # sms serialized as json in session, it is string key hash here
    @sms = Sms.new( phone: serialized_sms['phone'], code: serialized_sms['code'], send_at: serialized_sms['send_at'])
    @sms.verify_sign_up_sms( session['cellphone'],permitted_params['validate_code'])
  end

  def get_code_options
    code_options = {}
    if session["validate_phone"].present?
      code_options["validate_phone"] = session["validate_phone"]
      code_options["validate_code"] = session["validate_code"]
      code_options["validate_code_send_time"] = session["validate_code_send_time"]
    end
    code_options
  end

  def set_code_options(code_options)
    session["validate_phone"] = code_options["validate_phone"]
    session["validate_code"] = code_options["validate_code"]
    session["validate_code_send_time"] = code_options["validate_code_send_time"]
  end

end
