class PostsController < ApplicationController
  def index
    @posts = []

  end

  def new
    @post = current_user.posts.new
    @categories = Category.select("id, name")
    @subcategories = SubCategory.select("id, name, category_id").group_by(&:category_id)
  end

  def create
    @post = Post.create(params[:post].permit!)
    if @post.save
      flash[:success] = "Post created successfully"
      redirect_to posts_path
    else
      flash[:error] = "Not valid post"
    end
  end
end
