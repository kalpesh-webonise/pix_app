class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(content: params[:content], post_id: params[:post_id])
    if @comment.save
      owner = @comment.post.user
      user = @comment.user
      post_title = @comment.post.title
      UserMailer.comment_mail(owner, user.first_name, post_title,@comment.content).deliver if owner.id != user.id
      respond_to do |format|
      end
    else
      flash.now[:error] = "not created"
    end
  end
end
