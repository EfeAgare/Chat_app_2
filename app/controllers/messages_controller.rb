class MessagesController < ApplicationController
  before_action :require_login

  def create
    message = Message.create(body: params[:message][:body], user_message_id: session[:user_id])
    ActionCable.server.broadcast "chatroom_channel", 
                                    message: message_render(message)
    
  rescue
    message.destroy
  end


  def specific_message_create
    message = Message.create(body: params[:message][:body], user_message_id: session[:user_id],
                             friend_message_id: params[:message][:friend_message_id])
    ActionCable.server.broadcast "chatroom_channel", 
                                    message: message_render(message)
    
  rescue
    message.destroy
  end



  private

  def message_render(message)
    render(partial: 'message', locals: { message: message } )
  end
  
end 