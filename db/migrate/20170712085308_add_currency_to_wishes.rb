class AddCurrencyToWishes < ActiveRecord::Migration[5.0]
  def change
    add_column :wishes, :currency, :string
  end
end
