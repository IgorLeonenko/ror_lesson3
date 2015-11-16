class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      flash[:notice] = 'Comment was successfully created!'
      redirect_to root_path
    else
      flash[:alert] = "Cant add comment.\n#{@comment.errors.full_messages.join('')}"
      redirect_to root_path
    end
  end

  def update
    @comment = Comment.find_by(user:params[:user_id], post: params[:post_id])
    if @comment.update(comment_params)
      flash[:notice] = 'Comment was successfully updated!'
      redirect_to root_path
    else
      flash[:alert] = 'Can\'t update comment.\n#{@comment.errors.full_messages.join('')}'
      redirect_to root_path
    end
  end

  def destroy
    @comment = Comment.find_by(user:params[:user_id], post: params[:post_id])
    @comment.destroy
    redirect_to root_path
    flash[:notice] = 'Comment was successfully destroyed!'
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
