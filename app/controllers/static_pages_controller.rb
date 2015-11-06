class StaticPagesController < ApplicationController
  skip_before_action :authorization

  def index_page
    @posts = current_user ? Post.search(params[:search]).page(params[:page]).per(10) : Post.limit(10)
  end
end