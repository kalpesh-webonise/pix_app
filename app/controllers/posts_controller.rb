class PostsController < ApplicationController
  def index
    @posts = []

  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = current_user.posts.new
    get_categories_sub_categories
  end

  def create
    @post = current_user.posts.new(params[:post].permit!)
    if @post.save
      flash[:success] = "Post created successfully"
      redirect_to posts_path
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
end
