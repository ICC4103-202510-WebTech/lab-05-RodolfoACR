class MessagesController < ApplicationController
  def index
    @messages = Message.all
    respond_to do |format|
        format.html { render :index, locals: { messages: @messages } }
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
    params.require(:message).permit(:chat_id, :user_id, :body)
  end
end