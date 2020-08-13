class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_if_friends, only: [:index]
  # GET /posts
  # GET /posts.json
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = Post.where(user_id: params[:user_id]).order(:created_at)
    else
      @user = User.find(current_user.id)
      @posts = Post.where(user_id: current_user.id)
    end
    #@posts = Post.where(user_id: params[:user_id]).order(:created_at)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit    
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path(@post.user_id), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        STDOUT.puts "ERRORS HERE"
        STDOUT.puts @post.errors[:picture]
        @post.errors.each do |error|
          STDOUT.puts error
        end
        format.html { redirect_to new_user_post_path(current_user.id), notice: @post.errors.full_messages }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_post_path(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
    def check_if_friends
      #check params[:user_id] and see if current user if friends with them through request model
      @user = current_user
      @ary = Request.where(status: true, sent_by: @user.id).or(Request.where(status: true, sent_to:@user.id))
      other_friend_ids = @ary.map{|i| [i.sent_by, i.sent_to] }
      other_friend_ids.flatten!
      other_ids = other_friend_ids.select{|i| i.to_s != current_user.id.to_s }
      @friends = User.where(id: other_ids)
      if other_ids.include?(params[:user_id].to_i)
        return
      elsif current_user.id.to_s == params[:user_id].to_s
        return
      elsif params[:user_id].nil?
        return
      else
        flash[:notice] = "You are not friends with that person."
        redirect_to root_path
      end
    end
    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body, :user_id, :picture)
    end
end
