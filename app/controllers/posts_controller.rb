class PostsController < ApplicationController
  include JsonFormat

  before_action :set_post, only: [:show, :edit, :update, :destroy, :favorite_post, :unfavorite_post]
  before_action :user_check, only: [:edit, :update, :destroy]
  skip_before_action :authorization, only: :show

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(:user_id => current_user.id).search(params[:search]).page(params[:page]).per(10)
    respond_to do |format|
      format.html { @posts }
      format.json { render json: json_format(@posts) }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
    respond_to do |format|
      format.html { @post }
      format.json { render json: json_format(@post) }
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = 'Post was successfully created!'
      redirect_to user_posts_path
    else
      flash.now[:alert] = 'Can\'t create new post!'
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
      flash[:notice] = 'Post was successfully updated!'
      redirect_to user_posts_path
    else
      flash.now[:alert] = 'Can\'t update post!'
      render :edit
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    flash[:notice] = 'Post was successfully destroyed!'
    redirect_to user_posts_path
  end

  def favorite_posts
    @comment = Comment.new
    @favorites = current_user.favorites
  end

  def favorite_post
    current_user.favorites << @post
  end

  def unfavorite_post
    current_user.favorites.delete(@post)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :tag_list, :image_url)
    end

    def user_check
      unless @post.user_id == current_user.id
        flash[:alert] = 'You are not author!'
        redirect_to root_path
      end
    end
end
