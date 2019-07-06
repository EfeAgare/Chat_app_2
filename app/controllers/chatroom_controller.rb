# frozen_string_literal: true

class ChatroomController < ApplicationController
  include MessageHelper
  before_action :require_login

  def index
    @users = User.where('id != ?', session[:user_id])
    @message = Message.new
    @messages = fetch_all_messages_redis
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def chat_a_friend
    @users = User.where('id != ?', session[:user_id])
    @message = Message.new(friend_message_id: params[:user_id])
    @messages = fetch_specific_messages_redis

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
