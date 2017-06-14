class AddRatingToWishes < ActiveRecord::Migration[5.0]
  def change
    add_column :wishes, :rating, :integer
    add_index :wishes, :rating
  end
end
