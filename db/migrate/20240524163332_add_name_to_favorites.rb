class AddNameToFavorites < ActiveRecord::Migration[7.1]
  def change
    add_column :favorites, :name, :string
  end
end
