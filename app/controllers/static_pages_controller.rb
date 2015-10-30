class StaticPagesController < ApplicationController
  def index_page
    @posts = current_user ? Post.all : Post.where("created_at < ?", Date.yesterday)
  end
end