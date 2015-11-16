class CommentsController < ApplicationController

  before_action :set_post
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      flash[:notice] = 'Comment was successfully created!'
      check_path
    else
      flash[:alert] = "Cant add comment.\n#{@comment.errors.full_messages.join(',')}"
      check_path
    end
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment was successfully updated!'
      check_path
    else
      flash[:alert] = 'Can\'t update comment.\n#{@comment.errors.full_messages.join(',')}'
      check_path
    end
  end

  def destroy
    @comment.destroy
    check_path
    flash[:notice] = 'Comment was successfully destroyed!'
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = Comment.find_by(user:params[:user_id], post: params[:post_id])
    end

    def check_path
      redirect_to URI(request.referer).path == user_post_path(current_user, @post) ? :back : root_path
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
