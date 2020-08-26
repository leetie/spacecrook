class PagesController < ApplicationController
  def new
  end

  def index
  end

  def users_index
    @friend_ids = current_user.friends.ids
    @friend_ids << current_user.id
    @sent_request_ids = current_user.sent_requests.map {|r| r.sent_to }
    @incoming_request_ids = current_user.incoming_requests.map {|r| r.sent_by}
    # only show users that are not in current_user.friends, dont show current user, don't show user if they have a pending request with current user, and don't show users that have been sent a request already
    @users = User.where.not(id: @friend_ids).where.not(id: [@sent_request_ids]).where.not(id: [@incoming_request_ids])


  end

  def profile_info
    @user = current_user
    @posts = @user.posts.has_attached_picture
  end

  def about
  end
end
