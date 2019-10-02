# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :redirect
  include SessionsHelper

  private

  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to perform that action'
      redirect_to login_path
    end
  end

  def redirect
    redirect_to root_path
  end
end
