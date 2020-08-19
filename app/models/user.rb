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
  
  
  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  #-----check for provider attribute and render accordingly 
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!
    end
  end

  def email_required?
    false
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
