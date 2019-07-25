# frozen_string_literal: true

class ChatroomController < ApplicationController
  include MessageHelper
  before_action :require_login

  def index
    @users = User.where('id != ?', session[:user_id])
    @message = Message.new
    @messages = Message.where('friend_message_id is null').includes(:user_message, :friend_message)
    # @efe = fetch_all_messages_redis
    # binding.pry
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def chat_a_friend
    @users = User.where('id != ?', session[:user_id])
    @message = Message.new(friend_message_id: params[:user_id])
    @messages = Message.where("user_message_id = ? AND friend_message_id = ? OR
      user_message_id = ? AND friend_message_id = ? ",
                             session[:user_id], params[:friend_message_id],
                             params[:friend_message_id], session[:user_id]).includes(:user_message, :friend_message)
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
