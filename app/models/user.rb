class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

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

end
