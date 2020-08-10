class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :profile_picture, dependent: :destroy
  has_many :sent_requests, class_name: "Request", foreign_key: "sent_by", inverse_of: :sender
  has_many :incoming_requests, class_name: "Request", foreign_key: "sent_to", inverse_of: :receiver
  has_many :friends, class_name: "User", foreign_key: "user_id"
end
