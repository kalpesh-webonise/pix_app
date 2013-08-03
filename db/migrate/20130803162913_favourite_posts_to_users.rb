class FavouritePostsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favourite_post_ids, :text
  end
end
