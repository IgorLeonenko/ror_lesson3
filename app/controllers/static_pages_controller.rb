class StaticPagesController < ApplicationController
  include JsonFormat

  skip_before_action :authorization
  before_action :set_posts

  def index_page
    @comment = Comment.new
  end

  def json_page
    render json: json_format(@posts)
  end

  private

  def set_posts
    @posts =
    if current_user && params[:popular].present?
      Post.all.popular.limit(30).page(params[:page]).per(10)
    elsif current_user
      Post.search(params[:search]).page(params[:page]).per(10)
    else
      Post.limit(10)
    end
  end
end