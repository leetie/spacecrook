class PagesController < ApplicationController
  def new
  end

  def index
  end

  def users_index
    @users = User.all
  end

  def about
  end
end
