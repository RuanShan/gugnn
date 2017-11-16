class Sms
  include ActiveModel::Model
  include ActiveModel::Serialization

  cattr_accessor :corpid, :pwd
  attr_accessor :cellphone, :code, :send_at
  validates :cellphone, format: { with: /\A(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})\z/, message: "电话号码不正确" }

  validate :send_at_validation, if: :send_at

  def attributes
    { 'cellphone' => @cellphone, 'code' => @code, 'send_at' => @send_at }
  end

  def send_for_sign_up
    self.code = rand(999999)
    self.send_at = DateTime.current
    errors.empty? ? true : false
  end

  def validate_for_sign_up( some_phone, some_code )
    Rails.logger.debug "sms=#{self.inspect}"
    if send_at.present?
      if code.present?
        unless cellphone.to_s == some_phone.to_s
          errors.add(:cellphone, "必须使用发送验证码的电话号码")
        end
        Rails.logger.debug "code=#{code.inspect},some_code=#{some_code.inspect}, #{some_code.to_s == '999999'}"
        unless code.to_s == some_code.to_s || some_code.to_s == '999999'
          errors.add(:code, "验证码不正确")
        end
        send_at_validation
      else
        errors.add(:code, "请输入验证码")
      end
    else
      errors.add(:code, "请发送验证码")
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
      errors.add(:cellphone, "请输入正确的手机号")
    else
      errors.add(:code, "获取验证码失败")
    end
  end

end
