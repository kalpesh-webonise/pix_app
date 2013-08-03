class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    logger.info "##########################{params.inspect}"
    #raise error
    @comment = current_user.comments.new(content: params[:content], post_id: params[:post_id])
    if @comment.save
      render js:create
    else
      flash.now[:error] = "not created"
    end
  end
end
