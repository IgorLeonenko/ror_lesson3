class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorization, :counter
  helper_method :current_user

  protected

    def authorization
      unless current_user
        flash[:notice] = "Log In first"
        redirect_to root_path
      end
    end

  private

  def counter
    if session[:user_id].present?
      session[:count].nil? ? session[:count] = 0 : session[:count] += 1
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
