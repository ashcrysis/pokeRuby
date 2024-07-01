class RenameUserFieldsToEnglish < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :nome, :name
    rename_column :users, :telefone, :phone
    rename_column :users, :cep, :postal_code
    rename_column :users, :rua, :street
    rename_column :users, :numero, :number
    rename_column :users, :complemento, :complement
  end
end
