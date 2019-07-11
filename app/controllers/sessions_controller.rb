# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]

  def new; end

  def sign_up
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:info] = 'Account created successfully'
      redirect_to root_url
    else
      redirect_to login_url
    end
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    binding.pry
    if @user.blank?
      flash.now[:warning] = 'You need to create an account'
      redirect_to login_url
    elsif @user&.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = 'Welcome back'
      redirect_to root_url
    else
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to login_path
    end
  end

  def delete
    log_out
    redirect_to login_path
  end

  private

  def user_params
    if params[:session][:email]
      {
        username: params[:session][:username],
        email: params[:session][:email],
        password: params[:session][:password],
        image: params[:session][:image]
      }
    else
      {
        username: params[:session][:username],
        password: params[:session][:password]
      }
    end
  end

  def redirect_if_logged_in
    if logged_in?
      flash[:error] = 'Your are already logged in'
      redirect_to root_path
    end
  end
end
