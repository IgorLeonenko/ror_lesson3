class LikesController < ApplicationController
  def like_post
    @post = Post.find(params[:id])
    @like =  Like.find_by(user_id: current_user.id, post_id: @post.id)
    if current_user.dislike?(@post) && @post.dislike_count > 0
      @like.update_attributes(like: true, dislike: false)
    else
      @like = Like.new(user_id: current_user.id, post_id: @post.id, like: true)
      @like.save
    end
  end

  def dislike_post
    @post = Post.find(params[:id])
    @like =  Like.find_by(user_id: current_user.id, post_id: @post.id)
    if current_user.like?(@post) && @post.like_count > 0
      @like.update_attributes(like: false, dislike: true)
    else
      @like = Like.new(user_id: current_user.id, post_id: @post.id, dislike: true)
      @like.save
    end
  end
end
