class CommentsController < ApplicationController
  before_action :require_user_logged_in
  def create
    @comment = Comment.new(comment_params)
    @micropost = @comment.micropost
    if @comment.save
      respond_to :js
    else
      flash[:alert] = "コメントに失敗しました"
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @micropost = @comment.micropost
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = "コメントの削除に失敗しました"
    end
  end

  private
    def comment_params
      params.required(:comment).permit(:user_id, :micropost_id, :comment)
    end
end
