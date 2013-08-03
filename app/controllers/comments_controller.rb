class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.create(content: params[:content], post_id: params[:post_id])
    @comments = Comment.where("post_id = ?", params[:post_id])
    @comment = current_user.comments.new(content: params[:content], post_id: params[:post_id])
    if @comment.save
      owner = @comment.post.user
      user = @comment.user
      post_title = @comment.post.title
      UserMailer.comment_mail(owner, user.first_name, post_title,@comment.content).deliver
      respond_to do |format|
      end
    else
      flash.now[:error] = "not created"
    end
  end

end
