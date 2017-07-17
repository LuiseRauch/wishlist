class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column(:wishes, :price, :price_cents)
  end
end
