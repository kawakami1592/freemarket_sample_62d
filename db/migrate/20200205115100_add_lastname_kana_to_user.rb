class AddLastnameKanaToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :lastname_kana,   :string, null: false
    add_column :users, :first_name_kana, :string, null: false
    add_column :users, :birthyear,       :date,   null: false
    add_column :users, :birthmonth,      :date,   null: false
    add_column :users, :birthday,        :date,   null: false
  end
end
