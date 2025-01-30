class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    return if params[:message][:content].present? # Honey pot CAPTCHA for spam bots
    return if params[:message][:email].present? # Honey pot CAPTCHA for spam bots

    params[:message][:email] = params[:message][:mail]

    @message = Message.new(message_params)
    if @message.save
      DiscordMessageSender.new.send_message(@message)
      flash.now[:success] = t("message_sent")
    else
      # TODO
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :phone, :organisation, :body)
  end
end
