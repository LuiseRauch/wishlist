class AddPriceToWishes < ActiveRecord::Migration[5.0]
  def change
    add_column :wishes, :price, :string
  end
end
