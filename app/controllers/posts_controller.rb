class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.page(params[:page])
  end

  def show
    @comments = @post.comments.select("id, user_id, content, created_at").includes(:user).order("created_at DESC").limit(10)
  end

  def new
    @post = current_user.posts.new
    @post.photos.build
  end

  def create
    @post = current_user.posts.new(params[:post].permit!)
    if @post.save
      flash[:success] = "Post created successfully"
      redirect_to "/dashboard"
    else
      @post.photos.build
      render 'new'
    end
  end

  def edit
    @post.photos.build
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      @post.photos.build
      render 'edit'
    end
  end

  def mark_favourite
    @dom = current_user.mark_unmark_favourite(params)
    respond_to do |format|
      format.js
    end
  end


  def destroy
    if (current_user.is_admin || @post.user_id == current_user.id) && @post.destroy
      flash[:success] = "Post deleted successfully"
      redirect_to "/"
    else
      flash[:error] = "Unable to delete comment, please try after some time"
    end
  end

  private
  def post_params
    params.require(:post).permit(:category_id, :sub_category_id, :share, :title, :description, :location, :price, :name, :contact_number, :photos_attributes)
  end

end
