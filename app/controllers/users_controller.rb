class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  skip_before_action :authorization, only: [:new, :create]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies[:user_id] = { value: "#{@user.id}", expires: 12.hours.from_now }
      flash[:notice] = 'User created successfully!'
      redirect_to @user
    else
      flash.now[:alert] = 'Can\'t create user!'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.authenticate(params[:user][:current_password])
      params[:user].delete :current_password
      if @user.update(user_params)
        flash[:notice] = "User #{current_user.name.capitalize} was successfully updated."
        redirect_to @user
      else
        flash.now[:alert] = "Can\'t update user #{current_user.name.capitalize}!"
        render :edit
        p @user.errors
      end
    else
      flash[:alert] = "Current password incorrect"
      redirect_to edit_user_path(@user)
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
