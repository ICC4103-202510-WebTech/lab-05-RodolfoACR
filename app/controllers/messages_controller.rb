class MessagesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:index, :show]

  load_and_authorize_resource

  def authenticate_user!
    unless current_user
      redirect_to new_user_session_path, alert: "You must be logged in to access this section."
    end
  end

  def index
    if current_user.admin?
      @messages = Message.all
      respond_to do |format|
          format.html { render :index, locals: { messages: @messages } }
      end
    else
      @messages = Message.involving(current_user)
      respond_to do |format|
          format.html { render :index, locals: { messages: @messages } }
      end
    end
  end

  def show
    @message = Message.find(params[:id])
    respond_to do |format|
      format.html { render :show, locals: { message: @message } }
    @user = User.find(@message.user_id)
    @chat = Chat.find(@message.chat_id)
    end
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to messages_path, notice: "Message sended successfully."
    else
      render :new
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      redirect_to message_path(@message), notice: "Messagge updated successfully."
    else
      render :edit
    end
  end

  private

  def message_params
    if current_user.admin?
      params.require(:message).permit(:chat_id, :user_id, :body)
    else
      params.require(:message).permit(:chat_id, :body).merge(user_id: current_user.id)
    end
  end
end