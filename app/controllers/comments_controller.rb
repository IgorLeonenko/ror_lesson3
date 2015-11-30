class CommentsController < ApplicationController

  before_action :set_post
  before_action :set_comment, only: [ :edit, :update, :destroy ]
  before_action :user_check, only: [ :destroy ]

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post
    @comment.save
  end

  def edit
  end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = Comment.find_by(user:current_user.id, post: params[:post_id], id: params[:id])
    end

    def user_check
      unless @comment.user_id == current_user.id
        flash[:alert] = 'You are not author!'
        redirect_to root_path
      end
    end

    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end
end
