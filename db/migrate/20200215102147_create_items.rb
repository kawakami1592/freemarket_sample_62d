class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string     :name,         null: false
      t.text       :text
      t.references :user       
      t.integer :category_id
      t.integer :condition_id
      t.integer :deliverycost_id
      t.integer :pref_id
      t.integer :delivery_days_id
      t.integer    :price,        null: false

      t.timestamps
    end
  end
end
