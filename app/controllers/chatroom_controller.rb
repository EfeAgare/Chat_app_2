class ChatroomController < ApplicationController
  before_action :require_login

  def index
    @users = User.all
    @message = Message.new
    @messages = Message.all.includes(:user)
  end
end
