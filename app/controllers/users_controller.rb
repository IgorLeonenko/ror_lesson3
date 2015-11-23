class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  skip_before_action :authorization, only: [:new, :create]

  def index
    @users = Kaminari.paginate_array(User.all.sort_by(&:rating).reverse).page(params[:page]).per(6)
  end

  def show
  end

  def profile
    @user = User.find_by_name(params[:name])
    @user_posts = params[:all_posts].present? ? @user.posts : @user.posts.limit(5)
    @user_favorite_posts = params[:all_favorites].present? ? @user.favorites : @user.favorites.limit(5)
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
      @user = User.find_by_name(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
