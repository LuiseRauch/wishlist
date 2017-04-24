class AddListToWishes < ActiveRecord::Migration[5.0]
  def change
    add_column :wishes, :list_id, :integer
    add_index :wishes, :list_id
  end
end
