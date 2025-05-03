class ChatsController < ApplicationController
  def index
    chats = Chat.all
    respond_to do |format|
        format.html { render :index, locals: { chats: chats } }
    end
  end

  def show
    chat = Chat.find(params[:id])
    respond_to do |format|
      format.html { render :show, locals: { chat: chat } }
    end
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to chats_path, notice: "Chat creado exitosamente."
    else
      render :new
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end
