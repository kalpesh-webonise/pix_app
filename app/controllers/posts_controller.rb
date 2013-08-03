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
end
