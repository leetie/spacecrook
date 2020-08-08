class LikesController < ApplicationController
  before_action :set_post

  def create
    @post.likes.create(user_id: current_user.id)
    redirect_to user_posts_path(@post.user_id)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
