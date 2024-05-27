class AddImageUrlToFavorite < ActiveRecord::Migration[7.1]
  def change
    add_column :favorites, :image_url, :string
  end
end
