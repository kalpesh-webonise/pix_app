class PostsController < ApplicationController
  before_action :find_post, only: [:show]
  def index
    @posts = Post.page(params[:page])
  end

  def show
    @comments = @post.comments
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(params[:post].permit!)
    if @post.save
      flash[:success] = "Post created successfully"
      redirect_to "/dashboard"
    else
      get_categories_sub_categories
      render 'new'
    end
  end

  def get_categories_sub_categories
    @categories = Category.select("id, name")
    @subcategories = SubCategory.select("id, name, category_id").group_by(&:category_id)
  end

  def mark_favourite
    current_user.favourite_post_ids << params[:id].to_i
    current_user.favourite_post_ids.uniq!
    current_user.save
    respond_to do |format|
      format.js{ render nothing: true}
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if (current_user.is_admin || @post.user.id == current_user.id) && @post.present?
      @post.destroy
      respond_to do |format|
        flash[:success] = "Post deleted successfully"
        format.html { redirect_to "/" }
        format.json { head :no_content }
      end

    else
      flash.now[:error] = "You can't delete a Post"
    end
  end

  def edit

  end

  def update
  @post = Post.find(params[:id])
  @post.update_attribute()
  end
end
