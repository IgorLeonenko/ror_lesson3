class StaticPagesController < ApplicationController
  def index_page
    @posts = Post.where("created_at < ?", Date.yesterday)
  end
end