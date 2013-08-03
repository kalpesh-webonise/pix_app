class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    comment = current_user.comments.create(content: params[:content], post_id: params[:post_id])
    owner, post = comment.post.user, comment.post
    UserMailer.delay.comment_mail(owner, current_user.first_name, post.title, comment.content) if owner.id != current_user.id
    @comments = Comment.where("post_id = ?", params[:post_id])
  end

end
