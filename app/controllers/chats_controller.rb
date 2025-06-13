class ChatsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:index, :show]

  load_and_authorize_resource

  def authenticate_user!
    unless current_user
      redirect_to new_user_session_path, alert: "You must be logged in to access this section."
    end
  end

  def index
    @chats = Chat.all
    respond_to do |format|
        format.html { render :index, locals: { chats: @chats } }
    end
  end

  def show
    @chat = Chat.find(params[:id])
    respond_to do |format|
      format.html { render :show, locals: { chat: @chat } }
    @messages = Message.where(chat_id: @chat.id)
    end
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to chats_path, notice: "Chat created successfully."
    else
      render :new
    end
  end

  def edit
    @chat = Chat.find(params[:id])
  end

  def update
    @chat = Chat.find(params[:id])
    if @chat.update(chat_params)
      redirect_to chat_path(@chat), notice: "Chat updated successfully."
    else
      render :edit
    end
  end
  private

  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end
