class AddSlugToWishes < ActiveRecord::Migration[5.0]
  def change
    add_column :wishes, :slug, :string
    add_index :wishes, :slug, unique: true
  end
end
