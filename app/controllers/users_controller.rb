class UsersController < ApplicationController
  def index
    users = User.all
    respond_to do |format|
        format.html { render :index, locals: { users: users } }
    end
  end

  def show
    user = User.find(params[:id])
    respond_to do |format|
      format.html { render :show, locals: { user: user } }
    end
  end
end
