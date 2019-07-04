class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def require_login
    if !logged_in?
      flash[:error] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end
end
