class ChangePasswordTokenIndex < ActiveRecord::Migration
  def up
    remove_index :users, :reset_password_token
    add_index :users, :reset_password_token
  end

  def down
    remove_index :users, :reset_password_token
    add_index :users, :reset_password_token, unique: true
  end
end
