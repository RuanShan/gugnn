class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
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

  has_many :jointables, dependent: :destroy
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: 'http://i.imgur.com/7Yc9GZf.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  attr_accessor :validate_code, :current_password


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

  private

  def email_required?
    false
  end
end
