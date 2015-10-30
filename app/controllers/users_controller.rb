class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
    if @user.authenticate(params[:user][:current_password])
      params[:user].delete :current_password
      if @user.update(user_params)
        redirect_to @user, notice: "User #{@user.name} was successfully updated."
      else
        render :edit
      end
    else
      redirect_to edit_user_path(@user), notice: 'Current password incorrect'
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
