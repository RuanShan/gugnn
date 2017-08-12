class SmsController < ApplicationController
  before_action :build_sms, only: [:create_verify_code]

  def create_verify_code
    less_than_one_minute = false
    if session[:sms]
      last_send_time = Time.parse(session[:sms]['send_at'])
      send_duration = Time.now - last_send_time
      less_than_one_minute = send_duration <= 60
    end
    if less_than_one_minute
      @sms.errors.add(:validate_code, "验证码每分钟只能发送一次")
    else
      # validate phone number
      if @sms.valid?
        # send successfully
        if @sms.send_for_sign_up
          Rails.logger.debug "put in session, @sms.inspect=#{@sms.inspect}"
          session[:sms] = @sms
        end
      end
    end
  end

  private
    def build_sms
      @sms = Sms.new( phone: session[:cellphone] )
    end

    # Use callbacks to share common setup or constraints between actions.
    #def set_sms
    #  unless current_user
    #    session[:sign_up_sms]
    #  end
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def sms_params
    #  params.require(:phone)
    #end
end
