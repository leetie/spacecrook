class PagesController < ApplicationController
  def new
  end

  def index
  end

  def users_index
    @friend_ids = current_user.friends.ids
    @friend_ids << current_user.id
    @users = User.where.not(id: @friend_ids)
    #only show users that are not in current_user.friends and dont show current_user

  end

  def profile_info
    @user = current_user
    @posts = @user.posts.has_attached_picture
  end

  def about
  end
end
