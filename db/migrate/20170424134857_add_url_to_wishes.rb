class AddUrlToWishes < ActiveRecord::Migration[5.0]
  def change
    add_column :wishes, :url, :string
  end
end
