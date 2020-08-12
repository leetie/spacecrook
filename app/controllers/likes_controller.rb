class LikesController < ApplicationController
  before_action :set_post, except: [:comment_create, :comment_destroy]
  before_action :set_like, only: [:destroy]
  before_action :set_comment, only: [:comment_create, :comment_destroy]
  def create
    if already_liked?
      flash[:notice] = "You already liked that!"
    else
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to user_posts_path(@post.user_id)
  end

  def comment_create
    if comment_already_liked?
      flash[:notice] = "You already liked that!"
    else
      @comment.likes.create(user_id: current_user.id)
    end
    redirect_to user_posts_path(Post.find(@comment.post_id).user_id)
  end

  def comment_destroy
    if !comment_already_liked?
      flash[:notice] = "You haven't liked that yet!"
    else
      @like.destroy
      redirect_to user_posts_path(params[:user_id])
    end
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

  def comment_already_liked?
    Like.where(user_id: current_user.id, comment_id: params[:comment_id]).exists?
  end

  def set_like
    @like = @post.likes.find(params[:id])
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
    @like = Like.where(user_id: current_user.id, comment_id: params[:comment_id]).first
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
