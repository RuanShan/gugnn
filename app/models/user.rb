# 保存IP和对应的geocoding 信息。

class User < ApplicationRecord
  include AASM

  enum role: [:user, :vip, :admin], _prefix: true
  #   none:  没有认证
  #   ready: 认证信息准备好，
  #   done:  认证完成
  #   deny:  认证信息不合格
  enum id_auth_status: { none: 0,  ready:5, done:9, denied: 4 }, _prefix: true
  enum licence_auth_status: {none: 0, ready:5, done:9, denied: 4}, _prefix: true

  after_initialize :set_default_role, :if => :new_record?
  devise :database_authenticatable, authentication_keys: [:cellphone]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #用户的消息，
  has_many :messages

  has_many :products, dependent: :destroy, foreign_key: 'owner_id'


  belongs_to :category

  attr_reader :avatar_remote_url
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: 'missing/avatar.png'
  has_attached_file :id_photo, :styles => { :small => "150x150>", :large => "585x400>" },default_url: "default.png"
  has_attached_file :licence_photo, :styles => { :small => "150x150>", :large => "585x400>" },default_url: "default.png"
  validates_attachment_content_type :avatar, :id_photo, :licence_photo, content_type: /\Aimage\/.*\z/, size: { in: 0..5.megabytes }

  validates :shop_name, length: { in: 6..50 }, allow_blank:true
  validates :city, length: { in: 2..10 }, allow_blank:true
  validates :shop_address, length: { in: 6..20 }, allow_blank:true
  validates :contact_person, length: { in: 2..10 }, allow_blank:true
  validates :contact_phone, length: { in: 8..20 }, allow_blank:true
  validate :confirm_verification_code, on: :create

  #validates :shop_name, :id_number, :city, :shop_address, :contact_person, :contact_phone, presence: true, if: Proc.new{|user|user.}
  # sms对象，创建用户时检查短信验证码, :verification_code, 用户输入的验证码
  attr_accessor :sms,:verification_code, :current_password

  aasm( :id_auth_status, column: :id_auth_status, enum: true, namespace: :id )do
    state :none, :initial => true
    state :ready
    state :done
    state :deny
    event :submit, :after_commit => :notify_id_ready do
      transitions :from => :none, :to => :ready
    end
    event :deny do
      transitions :from => :ready, :to => :denied
    end
    event :allow do
      transitions :from => :ready, :to => :done
    end
  end

  aasm(  :licence_auth_status, column: :licence_auth_status, enum: true, namespace: :licence )do
    state :none, :initial => true
    state :ready
    state :done
    state :deny
    event :submit, :after_commit => :notify_licence_ready do
      transitions :from => :none, :to => :ready
    end
    event :deny do
      transitions :from => :ready, :to => :denied
    end
    event :allow do
      transitions :from => :ready, :to => :done
    end
  end

  def self.validate_phone(phone)
    if phone=~/\A(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})\z/
      self.exists?(cellphone: phone) ? "cellphone_exist" : "cellphone_not_exist"
    else
      "cellphone_invalid"
    end
  end

  def set_default_role
    self.role ||= :user
  end

  def change_password(password_options)
    unless encrypted_password.present?
      reset_password(password_options["password"],password_options["password_confirmation"] )
    else
      current_password = password_options["current_password"]
      if valid_password? current_password
        reset_password(password_options["password"],password_options["password_confirmation"] )
      else
        errors.add("current_password", "密码不正确")
      end
    end
  end

  def mask_phone
    cellphone[0,3]+"****"+cellphone[7,4]
  end

  def avatar_remote_url=(url_value)
    self.avatar = url_value
    # Assuming url_value is http://example.com/photos/face.png
    # avatar_file_name == "face.png"
    # avatar_content_type == "image/png"
    @avatar_remote_url = url_value
  end

  # 由于用户手机号码注册时，nickname为空， link_to current_user.nickname 会显示路径 my/account/
  # 设置缺省 ‘我的昵称’
  def nickname
    self['nickname'] || '我的昵称'
  end

  private
  def email_required?
    false
  end

  def password_required?
    !password.nil? || !password_confirmation.nil?
  end

  def notify_id_ready
    if id_auth_status_ready?
      admin = User.role_admin.first
      messages.create!  recipient: admin, title: "客户##{id}(#{cellphone})申请实名认证，请审查。"
    end
  end

  def notify_licence_ready
    if licence_auth_status_ready?
      admin = User.role_admin.first
      messages.create!  recipient: admin, title: "客户##{id}(#{cellphone})申请企业认证，请审查。"
    end
  end


  def confirm_verification_code
    #只有sms存在时才需要验证，加载seed时无需短信验证
    if sms.present?
      if !sms.validate_for_sign_up( self.cellphone, self.verification_code)
        Rails.logger.debug sms.errors.inspect
        errors.add("verification_code", sms.errors.first[1])
      end
    end
  end

end
