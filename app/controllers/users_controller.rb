class UsersController < ApplicationController
  skip_before_action :authorization, only: [:new, :create]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'User created successfull!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.authenticate(params[:user][:current_password])
      params[:user].delete :current_password
      if current_user.update(user_params)
        redirect_to current_user, notice: "User #{current_user.name.capitalize} was successfully updated."
      else
        render :edit
      end
    else
      redirect_to edit_user_path(current_user), notice: 'Current password incorrect'
    end
  end

  def destroy
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
