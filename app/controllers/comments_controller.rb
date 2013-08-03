class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(content: params[:content], post_id: params[:post_id])
    if @comment.save
      render js:create
    else
      flash.now[:error] = "not created"
    end
  end
end
