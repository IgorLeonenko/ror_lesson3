class StaticPagesController < ApplicationController
  skip_before_action :authorization

  def index_page
    @posts = current_user ? Post.all.page(params[:page]).per(10) : Post.last(10)
  end
end