class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorization, :counter
  before_action :first_time_visit?
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
    if cookies[:user_id].present?
      session[:count].nil? ? session[:count] = 0 : session[:count] += 1
    end
  end

  def current_user
    @current_user ||= User.find(cookies[:user_id]) if cookies[:user_id]
  end

  def first_time_visit?
    if session[:modal].nil?
      session[:modal] = 1
    else
      session[:modal] = 0
    end
  end

end
