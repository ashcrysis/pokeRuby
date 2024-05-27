class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :nome
      t.string :telefone
      t.string :cep
      t.string :rua
      t.string :numero
      t.string :complemento
      t.string :password

      t.timestamps
    end
  end
end
