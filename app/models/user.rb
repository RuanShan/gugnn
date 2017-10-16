# 保存IP和对应的geocoding 信息。

class User < ApplicationRecord
  enum role: [:user, :vip, :admin], _prefix: true
  #   none:  没有认证
  #   ready: 认证信息准备好，
  #   done:  认证完成
  #   deny:  认证信息不合格
  enum id_auth_status: [:none,:apply, :ready, :done, :deny ], _prefix: true
  enum licence_auth_status: [:none,:apply, :ready, :done, :deny ], _prefix: true

  after_initialize :set_default_role, :if => :new_record?
  devise :database_authenticatable, authentication_keys: [:cellphone]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :conversations, foreign_key: :sender_id
  has_many :events, through: :jointables

  has_many :rents, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :products, dependent: :destroy, foreign_key: 'owner_id'

  has_many :jointables, dependent: :destroy

  belongs_to :category

  attr_reader :avatar_remote_url
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/missing/avatar.png'
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
    current_password = password_options["current_password"]
    if valid_password? current_password
      reset_password(password_options["password"],password_options["password_confirmation"] )
    else
      errors.add("current_password", "密码不正确")
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

  private
  def email_required?
    false
  end

  def confirm_verification_code
    if sms.present?
      if !sms.validate_for_sign_up( self.cellphone, self.verification_code)
        Rails.logger.debug sms.errors.inspect
        errors.add("verification_code", "验证码不正确")
      end
    end
  end

end
