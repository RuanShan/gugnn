class Sms
  include ActiveModel::Model

  cattr_accessor :corpid, :pwd
  attr_accessor :phone, :code, :send_at
  validates :phone, length: { in: 7..11 }, format: { with: /\A\d+\z/, message: "must be number" }

  validate :send_at_validation, if: :send_at

  def initialize(attributes={})
    self.send_at = DateTime.current if attributes["send_at"].blank?
    self.code = rand(999999).to_s if attributes["code"].blank?
    super
  end

  def send_for_sign_up
    Rails.logger.debug "send code=#{code}"
    #Rails.logger.debug "code=#{code},ENV['GUGNN_CORPID']=#{ENV['GUGNN_CORPID']},ENV['GUGNN_PWD']=#{ENV['GUGNN_PWD']}"
    content = "您的验证码是：#{code}.请不要把验证码泄露给别人. 【光棍租机】"
    url = "http://api.bjszrk.com/sdk/BatchSend.aspx" \
          + "?CorpID=" + Sms.corpid \
          + "&pwd=" + Sms.pwd \
          + "&Mobile=" + phone \
          + "&Content="+content
    query_url = URI::escape(url)
    result = 1#open(query_url).read.to_i
    Rails.logger.debug "result=#{result}"
    get_sms_response_error(result) if result < 0
    errors.empty? ? true : false
  end

  def verify_sign_up_sms( some_phone, some_code )
    if send_at.present?
      if code.present?
        unless phone == some_phone.to_s
          errors.add(:phone, "必须使用发送验证码的电话号码")
        end
        Rails.logger.debug "code=#{code},some_code=#{some_code}"
        unless code.to_s == some_code.to_s
          errors.add(:validate_code, "验证码不正确")
        end
        send_at_validation
      else
        errors.add(:validate_code, "请输入验证码")
      end
    else
      errors.add(:validate_code, "请发送验证码")
    end
    errors.empty?
  end

  def send_at_validation
    if self.send_at
      last_send_duration = Time.now - self.send_at.to_time #
      if last_send_duration > 10*60
        errors.add(:send_at, "验证码过期，请重新发送")
      end
    end
  end

  def get_sms_response_error(code)
=begin
    –1 账号未注册
    –2 其他错误
    –3 帐号或密码错误
    –4 一次提交信息不能超过10000个手机号码，号码逗号隔开
    –5 余额不足，请先充值
    –6 定时发送时间不是有效的时间格式
    –8 发送内容需在3到250字之间
    -9 发送号码为空
    -104 短信内容包含关键字
=end
    if code == -9
      errors.add(:phone, "请输入正确的手机号")
    else
      errors.add(:validate_code, "获取验证码失败")
    end
  end

end
