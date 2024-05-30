class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.string :name
      t.string :image_url

      t.timestamps
    end
    add_belongs_to :favorites, :user, foreign_key: true
  end
end
