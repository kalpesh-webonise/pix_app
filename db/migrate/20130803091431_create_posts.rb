class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.boolean :share
      t.integer :owner_id
      t.integer :sub_category_id
      t.integer :category_id

      t.timestamps
    end
    add_index :posts, :sub_category_id
    add_index :posts, :category_id
  end
end
