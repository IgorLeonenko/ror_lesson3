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
    if current_user
      @posts = Post.find_by_params(params)
    else
      @posts = Post.all.limit(10)
    end
  end
end