class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def accept
    puts "in the accept method"
    @request = Request.where(sent_to: params[:sent_to], sent_by: params[:sent_by]).first
    @request.status = true
    if @request.save
      redirect_to requests_path
    end
  end
  def deny
    puts "in the deny method"
    @request = Request.where(sent_to: params[:sent_to], sent_by: params[:sent_by]).first
    @request.destroy
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
    puts "other friends are #{other_friend_ids} before flattening"
    other_friend_ids.flatten!
    other_ids = other_friend_ids.select{|i| i.to_s != current_user.id.to_s }
    puts "now other friend ids are #{other_ids}"
    @friends = User.where(id: other_ids)
  end

  def create
    @request = Request.new(request_params)
    @sent_to = User.find(params[:request][:sent_to])
    @sent_by = User.find(params[:request][:sent_by])

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
