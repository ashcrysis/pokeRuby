class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :nome
      t.string :moves
      t.string :tipo
      t.string :imagem

      t.timestamps
    end
  end
end
