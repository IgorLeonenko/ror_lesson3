class StaticPagesController < ApplicationController
  include JsonFormat

  skip_before_action :authorization
  before_action :set_posts

  def index_page
  end

  def json_page
    render json: json_format(@posts)
  end

  private

  def set_posts
    @posts = current_user ? Post.search(params[:search]).page(params[:page]).per(10) : Post.limit(10)
  end
end