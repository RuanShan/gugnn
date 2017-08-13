class RegistrationsController < Devise::RegistrationsController
  before_action :verify_sign_up_sms, only: [:create]

  def prepare
  end

  def validate_captcha
    error_message = User.validate_phone(params["cellphone"])
    if error_message=="cellphone_not_exist"
      session["cellphone"] = params["cellphone"]
      if verify_rucaptcha?
        session["captcha_valid"] = true
        redirect_to '/users/sign_up'
      else
        redirect_to '/prepare', alert: "captcha_invalid"
      end
    else
      redirect_to '/prepare', alert: error_message
    end
  end

  def new
    if session["cellphone"]
      if session["captcha_valid"] == true
        super
      else
        redirect_to '/prepare', alert: "captcha_invalid"
      end
    else
      redirect_to '/prepare', alert: "cellphone_invalid"
    end
  end

  def create
    permitted_params = sign_up_params
    permitted_params[:cellphone] = session["cellphone"]
    build_resource(permitted_params)
    resource.save
    unless @sms.errors.empty?
      @sms.errors.each{|key, value|
        resource.errors.add(key, value)
      }
    end
    logger.debug "resource1 = #{resource.errors.inspect}"
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        sign_in(resource_name, resource)
        if request.xhr?
          render :js => "window.location = '#{after_sign_up_path_for(resource)}';"
        else
          respond_with resource, location: after_sign_up_path_for(resource)
        end
      else
        logger.debug "resource = #{resource.inspect}"
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        if request.xhr?
          render :js => "window.location = '#{after_inactive_sign_up_path_for(resource)}';"
        else
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      if request.xhr?
        render 'shared/partials', locals:{ partial_hash: {"#sign_up_block"=>"sign_up"} }
      else
        respond_with resource
      end
    end

#      send_code = params["send_code"].to_i
#      code_options = get_code_options
#      @user.save_with_validate_code(send_code, sign_up_params, code_options)
#      set_code_options(code_options)
#      if @user.errors.empty?
#        flash[:notice] = "注册成功"
#        #if session["inviter_number"].present?
#        #  session.delete("inviter_number")
#        #end
#        if request.xhr?
#          render :js => "window.location = '#{new_user_session_path}';"
#        else
#          redirect_to new_user_session_path
#        end
#      else
#        if request.xhr?
#          render 'shared/partials', locals:{ partial_hash: {"#sign_up_block"=>"sign_up"} }
#        else
#          render "new"
#        end
#      end
#    else
#      flash[:notice] = "请阅读并同意服务条款和隐私政策" unless check_agreement?
#      @user.errors.add(:broker_number, "经纪人编码错误") if my_broker.blank?
#      if request.xhr?
#        render 'shared/partials', locals:{ partial_hash: {"#sign_up_block"=>"sign_up"} }
#      else
#        render "new"
#      end
#    end
  end

  private

  def sign_up_params
    permitted_params = [:nickname, :password, :validate_code]
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
