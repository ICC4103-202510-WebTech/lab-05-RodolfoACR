class MessagesController < ApplicationController
  def index
    messages = Message.all
    respond_to do |format|
        format.html { render :index, locals: { messages: messages } }
    end
  end

  def show
    message = Message.find(params[:id])
    respond_to do |format|
      format.html { render :show, locals: { message: message } }
    end
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to messages_path, notice: "Mensaje enviado correctamente."
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:chat_id, :user_id, :body)
  end
end