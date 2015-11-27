class LikesController < ApplicationController
  def like_post
    @post = Post.find(params[:id])
    @like =  Like.find_by(user_id: current_user.id, post_id: @post.id)
    unless current_user.id == @post.user_id
      if current_user.dislike?(@post) && @post.dislike_count > 0
        @like.update_attributes(like: true)
      else
        @like = Like.new(user_id: current_user.id, post_id: @post.id, like: true)
        @like.save
      end
    end
  end

  def dislike_post
    @post = Post.find(params[:id])
    @like =  Like.find_by(user_id: current_user.id, post_id: @post.id)
    unless current_user.id == @post.user_id
      if current_user.like?(@post) && @post.like_count > 0
        @like.update_attributes(like: false)
      else
        @like = Like.new(user_id: current_user.id, post_id: @post.id, like: false)
        @like.save
      end
    end
  end
end
