class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :picture, dependent: :destroy
  validate :acceptable_image


  def acceptable_image
    return unless picture.attached?

    unless picture.byte_size <= 5.megabyte
      errors.add(:picture, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(picture.content_type)
      errors.add(:picture, "must be a JPEG or PNG")
    end
  end
end
