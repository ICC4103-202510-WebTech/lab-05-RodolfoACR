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
end
