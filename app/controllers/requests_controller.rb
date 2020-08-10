class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def index
    @requests = Request.find(sent_to: current_user.id)
  end

  def create
    @request = Request.new(request_params)
    @sent_to = User.find(params[:request][:sent_to])
    @sent_by = User.find(params[:request][:sent_by])

    @sent_by.sent_requests << @request
    @sent_to.incoming_requests << @request
    if @request.save
      flash.notice = "Request made!"
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
