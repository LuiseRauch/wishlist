class AddUserToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :user_id, :integer
    add_index :lists, :user_id
  end
end
