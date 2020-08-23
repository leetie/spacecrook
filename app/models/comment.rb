class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, dependent: :destroy
  validates :body, presence: true, length: { maximum: 400}
end
