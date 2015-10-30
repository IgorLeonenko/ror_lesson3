class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_name(params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to @user, notice: 'You are log in!'
    else
      flash.now[:notice] = 'Name or password incorrect'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'You are log out!'
  end

end