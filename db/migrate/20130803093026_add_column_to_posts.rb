class AddColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :location, :string
    add_column :posts, :price, :integer
    add_column :posts, :name, :string
    add_column :posts, :conact_number, :string
  end
end
