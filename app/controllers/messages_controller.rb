# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :require_login

  def create
    message = Message.create(body: params[:message][:body], user_message_id: session[:user_id])
    ActionCable.server.broadcast 'chatroom_channel',
                                 message: message_render(message)
    if message.mentions
      message.mentions.each do |mention|
        ActionCable.server.broadcast "chatroom_channel_for_user_#{mention.id}",
                                    mention: true
      end
    end
  rescue ActiveRecord::RecordNotSaved
    redirect_to root_path
  end

  def specific_message_create
    message = Message.create(body: params[:message][:body], user_message_id: session[:user_id],
                             friend_message_id: params[:message][:friend_message_id])
    ActionCable.server.broadcast 'chatroom_channel',
                                 message: message_render(message)
  rescue ActiveRecord::RecordNotSaved
    redirect_to root_path
  end

  private

  def message_render(message)
    render(partial: 'message', locals: { message: message })
  end
end
