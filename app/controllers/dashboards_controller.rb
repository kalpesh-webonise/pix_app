class DashboardsController < ApplicationController
  def show
    @posts = Post.fetch_posts params, current_user
    @my_posts = current_user.posts
  end
end
