class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:index, :show]

  load_and_authorize_resource

  def authenticate_user!
    unless current_user
      redirect_to new_user_session_path, alert: "You must be logged in to access this section."
    end
  end

  def index
    @users = User.all
    respond_to do |format|
        format.html { render :index, locals: { users: @users } }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render :show, locals: { user: @user } }
    @chats = Chat.where("sender_id = ? OR receiver_id = ?", @user.id, @user.id)
    @messages = Message.where(user_id: @user.id)
    end
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User created successfully."
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render :edit, locals: { user: @user } }
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "User updated successfully."
    else
      render :edit
    end
  end

  private
  
  def user_params
    if current_user.admin?
      params.require(:user).permit(:first_name, :last_name, :email, :role)
    else
      params.require(:user).permit(:first_name, :last_name, :email)
    end
  end

end
