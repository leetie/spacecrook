class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def accept
    @request = Request.where(sent_to: params[:sent_to], sent_by: params[:sent_by]).first
    @request.status = true
    if @request.save
      #find id that doesnt belong to current_user
      if params[:sent_to].to_i == current_user.id.to_i
        @other_id = params[:sent_by]
      else
        @other_id = params[:sent_to]
      end
      #create a friend for both users
      Friendship.create(friend_id: @other_id, user_id: current_user.id)
      redirect_to requests_path
      Friendship.create(user_id: @other_id, friend_id: current_user.id)
      flash[:notice] = "Request Accepted!"
    end
  end
  def deny
    puts "in the deny method"
    @request = Request.where(sent_to: params[:sent_to], sent_by: params[:sent_by]).first
    @request.destroy
    flash[:notice] = "Request Denied."
    redirect_to requests_path
  end
  def index
    @requests = Request.where(sent_to: current_user.id, status: false)
  end
  
  def friends
    ##add scope in model for this stuff
    @user = User.find(params[:user_id])
    @ary = Request.where(status: true, sent_by: @user.id).or(Request.where(status: true, sent_to:@user.id))

    other_friend_ids = @ary.map{|i| [i.sent_by, i.sent_to] }
    other_friend_ids.flatten!
    other_ids = other_friend_ids.select{|i| i.to_s != current_user.id.to_s }
    @friends = User.where(id: other_ids)
  end

  def create
    @request = Request.new(request_params)
    @sent_to = User.find(params[:request][:sent_to])
    @sent_by = User.find(params[:request][:sent_by])
    # if @sent_to.id == 1 || @sent_to.id == "1"
    #   @request.status = true
    #   #create a friend for both users
    #   Friendship.create(user_id: current_user.id, friend_id: 1)
    #   Friendship.create(friend_id: current_user.id, user_id: 1)
    # end
    @sent_by.sent_requests << @request
    @sent_to.incoming_requests << @request
    if @request.save
      flash[:notice] = "Request made!"
      redirect_back fallback_location: root_path
    else
      redirect_to root_path
    end
  end

  def destroy
  end

  private

  def request_params
    params.require(:request).permit(:sent_by, :sent_to)
  end
end
