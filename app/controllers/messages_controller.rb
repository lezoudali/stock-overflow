class MessagesController < ApplicationController

  def create
    Message.create(message_params)
  end

  def message_params
    params.require(:message).permit(:user_id, :stock_id, :content)
  end
end
