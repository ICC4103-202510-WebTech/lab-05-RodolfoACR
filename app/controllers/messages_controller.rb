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
end