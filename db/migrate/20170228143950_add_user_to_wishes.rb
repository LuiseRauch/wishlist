class AddUserToWishes < ActiveRecord::Migration[5.0]
  def change
    add_column :wishes, :user_id, :integer
    add_index :wishes, :user_id
  end
end
