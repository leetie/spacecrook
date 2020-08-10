class Request < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sent_by", inverse_of: :sent_requests
  belongs_to :receiver, class_name: "User", foreign_key: "sent_to", inverse_of: :incoming_requests

  validate :users_exist

  def users_exist
    # if User.find(:sent_by) == nil
    #   errors.add(:sent_by, "How did you send a friend request if you dont exist...??")
    # elsif User.find(:sent_to) == nil
    #   errors.add(:sent_to, "Other user not found!")
    # end
  end
end
