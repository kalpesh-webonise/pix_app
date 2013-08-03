class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    comment = current_user.comments.create(content: params[:content], post_id: params[:post_id])
    owner, post = comment.post.user, comment.post
    UserMailer.comment_mail(owner, current_user.first_name, post.title, comment.content).deliver if owner.id != current_user.id
    @comments = Comment.where("post_id = ?", params[:post_id])
  end

  def destroy
    comment = Comment.find(params[:id])
    post = comment.post
    if  comment.present?
      comment.destroy
      respond_to do |format|
        flash[:success] = "Comment deleted successfully"
        format.html { redirect_to post_path(post) }
        format.json { head :no_content }
      end
    else
      flash.now[:error] = "You can't delete a Comment"
    end
  end
end
