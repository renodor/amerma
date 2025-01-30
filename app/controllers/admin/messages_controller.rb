class Admin::MessagesController < ApplicationController
  layout "admin"

  def index
    @messages = Message.all.order(created_at: :desc)
  end

  def show
    @message = Message.find(params[:id])
  end

  def destroy
    Message.find(params[:id]).destroy
    redirect_to admin_messages_path
  end
end
