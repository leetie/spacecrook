class LikesController < ApplicationController
  before_action :set_post
  before_action :set_like, only: [:destroy]
  def create
    if already_liked?
      flash[:notice] = "You already liked that!"
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to user_posts_path(@post.user_id)
  end

  def destroy
    if !already_liked?
      flash[:notice] = "You haven't liked that yet"
    else
      @like.destroy
    end
    redirect_to user_posts_path(@post.user_id)
  end

  private

  def already_liked?
    Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
  end

  def set_like
    @like = @post.likes.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
