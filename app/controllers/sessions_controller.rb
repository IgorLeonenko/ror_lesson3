class SessionsController < ApplicationController
  skip_before_action :authorization

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      cookies[:user_id] = { value: "#{@user.id}", expires: 12.hours.from_now }
      flash[:notice] = 'You are log in!'
      redirect_to @user
    else
      flash.now[:alert] = 'Name or password incorrect'
      render :new
    end
  end

  def destroy
    cookies.delete(:user_id)
    session.delete(:count)
    redirect_to root_path, notice: 'You are log out!'
  end

end