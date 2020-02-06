class RenamePhoneeColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :phonee, :phone
    rename_column :users, :first_name_kana, :firstname_kana
  end
end