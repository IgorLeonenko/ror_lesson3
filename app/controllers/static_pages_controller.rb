class StaticPagesController < ApplicationController
  skip_before_action :authorization

  def index_page
    @posts = current_user ? Post.all : Post.last(10)
  end
end