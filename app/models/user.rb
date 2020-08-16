class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:twitter]
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :profile_picture, dependent: :destroy
  has_one_attached :profile_background, dependent: :destroy
  has_many :sent_requests, class_name: "Request", foreign_key: "sent_by", inverse_of: :sender
  has_many :incoming_requests, class_name: "Request", foreign_key: "sent_to", inverse_of: :receiver
  has_many :friends, class_name: "User", foreign_key: "user_id"
  validate :acceptable_image
  validates :name, presence: true
  has_many :friendships
  has_many :friends, through: :friendships

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
  
  protected 
  def acceptable_image
    return unless profile_picture.attached?

    unless profile_picture.byte_size <= 5.megabyte
      errors.add(:profile_picture, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(profile_picture.content_type)
      errors.add(:profile_picture, "must be a JPEG or PNG")
    end
  end
end
