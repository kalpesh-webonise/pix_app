class PostsController < ApplicationController
  def index
    @posts = []

  end

  def show
    @post = Post.find(params[:id])
    #respond_to do |format|
    #  format.html #show.html
    #  format.js
    #  format.json { render :json => @host }
    #end
    #@all_comments = @post.comments
  end

  #def show_comments
  #
  #end

  def new
    logger.info "###########################{current_user.inspect}"
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
end
