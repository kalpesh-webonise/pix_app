class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.create(content: params[:content], post_id: params[:post_id])
    @comments = Comment.where("post_id = ?", params[:post_id])
  end
end
