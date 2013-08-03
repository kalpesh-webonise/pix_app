class RenameContactNo < ActiveRecord::Migration
  def change
    rename_column :posts, :conact_number, :contact_number
  end
end
