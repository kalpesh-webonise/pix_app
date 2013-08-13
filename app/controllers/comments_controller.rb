class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy]

  def older
    @comments = Comment.where("post_id = ? AND id < ?", params[:post_id], params[:id]).includes(:user).select("id, content, user_id, created_at").order("created_at DESC").limit(10)
  end

  def create
    comment = current_user.comments.new(content: params[:content], post_id: params[:post_id])
    comment.save_and_mail(current_user)
    @comments = Comment.recent_comments(params[:recent_comment_id], params[:post_id])
  end

  def recent
    @comments = Comment.recent_comments(params[:recent_comment_id], params[:post_id])
    respond_to do |format|
      format.js {render "create"}
    end
  end

  def destroy
    if @comment.user_id == current_user.id || current_user.is_admin
      @comment.destroy
        flash[:success] = "Comment deleted successfully"
    else
      flash[:error] = "Access denied"
    end
    respond_to do |format|
      format.html { redirect_to post_path(@comment.post_id) }
      format.json { head :no_content }
    end
  end
end
